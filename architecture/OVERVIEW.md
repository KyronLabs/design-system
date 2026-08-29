# Architecture Overview

## 🏗️ System Architecture Philosophy

Kyron's architecture is built on **portable identity** and **decentralized social graph** principles. We combine the best of modern social platforms with cryptographic ownership.

---

## 🎯 Core Principles

### 1. User Ownership First
- Every user has a **DID (Decentralized Identifier)**
- Data is **user-owned** and portable
- Identity is **cryptographically verified**
- Users can **migrate** their data and followers

### 2. Performance Obsession
- **TikTok-grade discovery**: Vector ranking with <200ms response
- **Instagram AR**: 30fps camera with real-time lenses
- **YouTube shelf-life**: Content that lasts and remains discoverable
- **Bluesky portability**: AT Protocol for federated identity

### 3. Microservice Pattern
- **Single responsibility** per service
- **Loose coupling** between services
- **Event-driven** communication
- **Scalable** by design

### 4. Offline-First
- **Client-side caching** for resilience
- **Optimistic updates** for instant feedback
- **Conflict resolution** for offline changes
- **Background sync** when connectivity returns

---

## 📊 High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────────────┐
│                           KYRON ECOSYSTEM                                    │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────────┐    ┌─────────────────────┐    ┌─────────────┐ │
│  │   Mobile Client      │    │    Web Client        │    │   AR Camera  │ │
│  │   (Flutter)          │    │    (Flutter Web)     │    │   (Flutter)  │ │
│  └──────────┬───────────┘    └──────────┬───────────┘    └──────┬──────┘ │
│             │                            │                        │          │
│             └────────────────────────────┼────────────────────────┘          │
│                                          ▼                                    │
│                    ┌─────────────────────────────────┐                   │
│                    │      API Gateway (NestJS)       │                   │
│                    │  - Authentication (JWT)          │                   │
│                    │  - Request Routing               │                   │
│                    │  - Rate Limiting                 │                   │
│                    │  - WebSocket Management          │                   │
│                    └──────────────┬──────────────────┘                   │
│                                   │                                        │
│         ┌─────────────────────────┼─────────────────────────┐           │
│         ▼                         ▼                         ▼               │
│  ┌──────────────┐         ┌──────────────┐         ┌──────────────┐    │
│  │ Feed Service │         │ Media Service │         │Identity Node │    │
│  │ (NestJS)     │         │ (GStreamer)   │         │ (TypeScript)  │    │
│  │              │         │              │         │              │    │
│  │ - Embeddings │         │ - Transcode  │         │ - DID        │    │
│  │ - Ranking    │         │ - Thumbnail  │         │ - Repo Sign  │    │
│  │ - Redis      │         │ - AI Caption │         │ - PLC Reg    │    │
│  │   Streams    │         │              │         │              │    │
│  └──────┬───────┘         └──────┬───────┘         └──────┬───────┘    │
│         │                        │                        │               │
│         ▼                        ▼                        ▼               │
│  ┌─────────────────────────────────────────────────────────────┐        │
│  │                        INFRASTRUCTURE                         │        │
│  │  ┌─────────┐  ┌─────────┐  ┌─────────────┐  ┌─────────────┐  │        │
│  │  │ Postgres│  │  Redis  │  │ Pinecone    │  │ S3-Compatible│  │        │
│  │  │         │  │         │  │ (Vector DB) │  │ Storage     │  │        │
│  │  └─────────┘  └─────────┘  └─────────────┘  └─────────────┘  │        │
│  └─────────────────────────────────────────────────────────────┘        │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 🔄 Data Flow Patterns

### 1. Post Creation Flow

```
┌─────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│  User   │────▶│   Client     │────▶│   Gateway    │────▶│ Media Service │
│         │     │ (Flutter)     │     │ (NestJS)     │     │ (GStreamer)   │
└─────────┘     └──────────────┘     └──────────────┘     └──────────────┘
                                                           │
                                                           ▼
                                                    ┌──────────────┐
                                                    │   S3         │
                                                    │ (Upload)     │
                                                    └──────────────┘
                                                           │
                                                           ▼
                                                    ┌──────────────┐
                                                    │ Media Service │
                                                    │ (Transcode)   │
                                                    └──────────────┘
                                                           │
                                                           ▼
                                                    ┌──────────────┐
                                                    │ Feed Service  │
                                                    │ (Embeddings)  │
                                                    └──────────────┘
                                                           │
                                                           ▼
                                                    ┌──────────────┐
                                                    │ Redis Stream  │
                                                    │ (Fan-out)     │
                                                    └──────────────┘
                                                           │
         ┌─────────────────────────────────────────────────────────┐
         ▼                                                         ▼
┌──────────────┐                                      ┌──────────────┐
│ Follower 1    │                                      │ Follower N    │
│ (WebSocket)   │                                      │ (WebSocket)   │
└──────────────┘                                      └──────────────┘
```

**Steps:**
1. User creates post in Flutter client
2. Client sends to Gateway with JWT
3. Gateway validates and routes to Media Service
4. Media Service generates signed URL for S3
5. Client uploads media directly to S3
6. Media Service transcodes, generates thumbnails
7. AI service generates captions, embeddings
8. Feed Service stores embeddings, creates post record
9. Feed Service publishes to Redis Stream
10. Gateway pushes to all followers via WebSocket

### 2. Feed Retrieval Flow

```
┌─────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│  User   │────▶│   Client     │────▶│   Gateway    │────▶│ Feed Service  │
│         │     │ (Flutter)     │     │ (NestJS)     │     │ (NestJS)      │
└─────────┘     └──────────────┘     └──────────────┘     └──────────────┘
                                                           │
                                                           ▼
                                                    ┌──────────────┐
                                                    │  Pinecone    │
                                                    │ (Vector DB)  │
                                                    └──────────────┘
                                                           │
                                                           ▼
                                                    ┌──────────────┐
                                                    │   Postgres    │
                                                    │ (Posts, Users)│
                                                    └──────────────┘
                                                           │
                                                           ▼
                                                    ┌──────────────┐
                                                    │   Client     │
                                                    │ (Vector Cache│
                                                    │  + Render)   │
                                                    └──────────────┘
```

**Steps:**
1. User opens feed in Flutter client
2. Client requests feed from Gateway
3. Gateway authenticates and routes to Feed Service
4. Feed Service queries Pinecone for vector similarity
5. Feed Service retrieves post data from Postgres
6. Feed Service returns ranked feed to Gateway
7. Gateway returns feed to Client
8. Client caches feed data (vector cache)
9. Client renders feed with optimized widgets

### 3. Reaction Flow

```
┌─────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│  User   │────▶│   Client     │────▶│   Gateway    │────▶│   Postgres    │
│ (Tap)   │     │ (Optimistic  │     │ (NestJS)     │     │ (Reactions)   │
└─────────┘     │  Update)      │     └──────────────┘     └──────────────┘
                └──────────────┘           │
                                              ▼
                                       ┌──────────────┐
                                       │  Supabase     │
                                       │ (Realtime)    │
                                       └──────────────┘
                                              │
         ┌─────────────────────────────────────────────────────────┐
         ▼                                                         ▼
┌──────────────┐                                      ┌──────────────┐
│ Other Clients │                                      │   Client     │
│ (Realtime)    │                                      │ (Rollback if │
└──────────────┘                                      │   Failed)     │
                                              └──────────────┘
```

**Steps:**
1. User taps reaction button
2. Client updates UI optimistically (instant feedback)
3. Client sends reaction to Gateway
4. Gateway validates and writes to Postgres
5. Supabase publishes realtime update
6. All clients receive update via WebSocket
7. If write fails, client rolls back optimistic update

---

## 🔐 Security Architecture

### Authentication Flow

```
┌─────────┐     ┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│  User   │────▶│   Client     │────▶│   Gateway    │────▶│ Identity Node │
│         │     │ (Flutter)     │     │ (NestJS)     │     │ (AT Protocol) │
└─────────┘     └──────────────┘     └──────────────┘     └──────────────┘
                                                           │
                                                           ▼
                                                    ┌──────────────┐
                                                    │   PLC        │
                                                    │ (Registry)    │
                                                    └──────────────┘
```

**AT Protocol Authentication:**
1. User initiates login from client
2. Client requests authentication from Gateway
3. Gateway generates session challenge
4. Client signs challenge with user's DID key
5. Gateway verifies signature with Identity Node
6. Identity Node checks PLC registry for DID
7. Gateway issues JWT for session
8. Client stores JWT securely

### Data Security

**Encryption:**
- **At Rest**: All data encrypted in database
- **In Transit**: TLS 1.3 for all connections
- **End-to-End**: Optional E2EE for private posts

**Privacy Levels:**
1. **Public**: Visible to everyone
2. **Followers Only**: Visible to approved followers
3. **Private**: Visible only to user
4. **E2EE**: End-to-end encrypted, only user can decrypt

### Rate Limiting

**Per-User Limits:**
- **API Requests**: 1000/minute
- **Post Creation**: 50/hour
- **Reactions**: 200/hour
- **Follows**: 100/hour
- **WebSocket Messages**: 1000/minute

**Per-IP Limits:**
- **Authentication**: 10/minute
- **API Requests**: 500/minute

---

## 📈 Scalability Architecture

### Horizontal Scaling

**Stateless Services:**
- Gateway: Multiple instances behind load balancer
- Feed Service: Multiple instances with shared Redis
- Media Service: Multiple workers with queue

**Stateful Services:**
- Postgres: Read replicas for scaling reads
- Redis: Cluster mode for scaling
- Identity Node: Sharded by DID

### Caching Strategy

**Layer 1 - Client:**
- Vector cache for feed posts
- Image cache for media
- Offline data for resilience

**Layer 2 - Gateway:**
- JWT validation cache
- Rate limiting cache
- User session cache

**Layer 3 - Services:**
- Feed Service: Ranked feed cache (5 minutes)
- Media Service: Thumbnail cache (24 hours)
- Identity Node: DID resolution cache (1 hour)

### Database Strategy

**Postgres:**
- Primary for all structured data
- Read replicas for scaling
- Connection pooling
- Query optimization

**Redis:**
- Real-time pub/sub
- Session storage
- Rate limiting
- Temporary data

**Pinecone:**
- Vector embeddings storage
- Similarity search
- Horizontal scaling

**S3-Compatible:**
- Media storage (images, videos)
- CDN for delivery
- Lifecycle policies

---

## 🔄 Failover & Redundancy

### High Availability

**Multi-Region Deployment:**
- Primary region: US East
- Secondary region: EU West
- Tertiary region: Asia Pacific

**Failover Strategy:**
1. **Database**: Primary → Read Replica → Secondary Region
2. **Services**: Load balancer health checks, auto-removal
3. **Storage**: Multi-region replication
4. **CDN**: Multi-region edge caching

### Disaster Recovery

**Backup Strategy:**
- **Postgres**: Daily snapshots + WAL archiving
- **Redis**: RDB snapshots every 6 hours
- **S3**: Versioning + cross-region replication
- **Configuration**: Git + encrypted secrets

**Recovery Time Objectives:**
- **Database**: 15 minutes
- **Services**: 5 minutes
- **Storage**: 1 hour
- **Full System**: 4 hours

---

## 📊 Monitoring & Observability

### Metrics

**Application Metrics:**
- Request rates and latencies
- Error rates
- User engagement
- Performance percentiles

**Infrastructure Metrics:**
- CPU, memory, disk usage
- Network throughput
- Database query performance
- Cache hit rates

### Logging

**Structured Logging:**
- JSON format for all logs
- Request ID for correlation
- User ID for user-specific debugging
- Severity levels (DEBUG, INFO, WARN, ERROR)

**Log Retention:**
- Debug logs: 7 days
- Info logs: 30 days
- Error logs: 90 days
- Audit logs: 7 years

### Tracing

**Distributed Tracing:**
- OpenTelemetry for tracing
- Trace ID for request correlation
- Service-to-service tracing
- Performance analysis

### Alerting

**Critical Alerts:**
- Service down
- Database connection failures
- High error rates
- Performance degradation

**Warning Alerts:**
- High memory usage
- High CPU usage
- Low disk space
- High latency

---

## 🔧 Deployment Strategy

### Environments

| Environment | Purpose | Auto-Deploy | Access |
|-------------|---------|-------------|--------|
| Local | Development | No | Localhost |
| Dev | Testing | Yes (main) | Internal |
| Staging | Pre-production | Yes (release) | Internal |
| Production | Live | Manual | Public |

### Deployment Process

```
1. Code committed to main branch
2. CI pipeline runs tests
3. If tests pass, deploy to Dev
4. Manual testing in Dev
5. Tag release (vX.Y.Z)
6. Deploy to Staging
7. Final testing in Staging
8. Manual approval for Production
9. Deploy to Production
10. Monitor for issues
```

### Rollback Strategy

**Automatic Rollback:**
- Health check failures
- High error rates
- Performance degradation

**Manual Rollback:**
- Critical bugs
- Security issues
- Data corruption

---

## 📚 References

- [Kyron Main Architecture](https://github.com/KyronLabs/kyron/blob/main/ARCHITECTURE.md)
- [Folder Structure](https://github.com/KyronLabs/kyron/blob/main/FOLDER_STRUCTURE.md)
- [AT Protocol Specification](https://atproto.com/specs/)
- [Bluesky ALF Design System](https://github.com/bluesky-social/social-app/tree/main/src/alf)

---

*"Great architecture is invisible. It just works."*

**Architecture Documentation** — Version 1.0 — Kyron Design System
