# Microservices Design

## 🎯 Microservice Philosophy

Kyron's architecture follows a **microservice pattern** where each service has a single, well-defined responsibility. This approach provides:

- **Independent Scaling**: Scale services based on demand
- **Technology Flexibility**: Use the best tool for each job
- **Fault Isolation**: Failure in one service doesn't affect others
- **Team Autonomy**: Teams can work on services independently
- **Continuous Deployment**: Deploy services independently

---

## 📋 Service Catalog

### 1. API Gateway

**Technology**: NestJS (TypeScript)
**Port**: 3000
**Protocol**: HTTP/1.1, WebSocket

#### Responsibilities

- **Authentication**: JWT validation, session management
- **Authorization**: Permission checks, role-based access
- **Routing**: Request routing to appropriate services
- **Rate Limiting**: Per-user and per-IP rate limiting
- **WebSocket Management**: Connection handling, message routing
- **Request/Response Transformation**: API versioning, format conversion

#### Endpoints

```
GET  /api/v1/feed              - Get user's feed
POST /api/v1/posts            - Create a new post
GET  /api/v1/posts/:id        - Get a specific post
POST /api/v1/reactions        - Add/remove a reaction
GET  /api/v1/notifications    - Get user notifications
POST /api/v1/follows          - Follow/unfollow a user
GET  /api/v1/users/:handle    - Get user profile
POST /api/v1/auth/login       - User login
POST /api/v1/auth/refresh     - Refresh JWT token
POST /api/v1/media/upload     - Initiate media upload

WS   /ws                     - WebSocket connection
```

#### Dependencies

- Postgres (user data, sessions)
- Redis (rate limiting, caching)
- Feed Service (feed data)
- Media Service (media uploads)
- Identity Node (DID verification)

#### Scaling

- **Horizontal**: Multiple instances behind load balancer
- **Stateless**: No local state, all data in external stores
- **Concurrency**: 1000 concurrent connections per instance

---

### 2. Feed Service

**Technology**: NestJS (TypeScript)
**Port**: 3001
**Protocol**: HTTP/1.1, gRPC

#### Responsibilities

- **Embedding Generation**: Generate vector embeddings for posts
- **Ranking**: Rank posts using vector similarity and social signals
- **Feed Construction**: Build personalized feeds for users
- **Real-time Updates**: Push new posts to followers via Redis Streams
- **Trending**: Calculate trending posts and topics

#### Endpoints

```
POST /api/v1/embeddings        - Generate embeddings for text
POST /api/v1/rank             - Rank posts for a user
GET  /api/v1/feed/:userId     - Get feed for a user
POST /api/v1/posts             - Create a post (internal)
GET  /api/v1/trending         - Get trending posts
POST /api/v1/search            - Search posts
```

#### gRPC Services

```protobuf
service FeedService {
  rpc GenerateEmbeddings (GenerateEmbeddingsRequest) returns (EmbeddingsResponse);
  rpc RankPosts (RankPostsRequest) returns (stream RankedPost);
  rpc GetFeed (GetFeedRequest) returns (FeedResponse);
}
```

#### Dependencies

- Postgres (posts, reactions, follows)
- Pinecone (vector embeddings, similarity search)
- Redis (real-time fan-out, caching)

#### Scaling

- **Horizontal**: Multiple instances
- **Stateless**: All state in external stores
- **Concurrency**: 500 concurrent ranking operations per instance

---

### 3. Media Service

**Technology**: GStreamer + Rust
**Port**: 3002
**Protocol**: HTTP/1.1

#### Responsibilities

- **Upload Management**: Generate signed URLs for S3 uploads
- **Transcoding**: Convert media to multiple formats and resolutions
- **Thumbnail Generation**: Generate thumbnails for images and videos
- **AI Processing**: Run AI models for caption generation, object detection
- **Media Optimization**: Optimize media for different devices and network conditions

#### Endpoints

```
POST /api/v1/upload           - Generate signed URL for upload
POST /api/v1/transcode        - Trigger transcoding (internal)
GET  /api/v1/media/:id        - Get media metadata
GET  /api/v1/media/:id/thumb  - Get thumbnail
POST /api/v1/caption          - Generate caption for media
```

#### Media Processing Pipeline

```
Client Upload → S3 → Media Service → Transcode → Thumbnail → AI Caption → Metadata
                     ↓
              ┌─────────────────────────────┐
              │   GStreamer Pipeline         │
              │  1. Demux                   │
              │  2. Decode                  │
              │  3. Scale (multiple res)    │
              │  4. Encode (H.264, VP9, etc)│
              │  5. Mux                     │
              └─────────────────────────────┘
                     ↓
              ┌─────────────────────────────┐
              │   Rust Workers               │
              │  - Thumbnail generation      │
              │  - Metadata extraction       │
              │  - Format conversion         │
              └─────────────────────────────┘
                     ↓
              ┌─────────────────────────────┐
              │   AI Models                  │
              │  - Caption generation        │
              │  - Object detection          │
              │  - Scene classification      │
              └─────────────────────────────┘
```

#### Supported Formats

**Input:**
- Images: JPEG, PNG, WebP, HEIC, GIF
- Videos: MP4, MOV, WebM, AV1
- Audio: MP3, AAC, OGG, WAV

**Output:**
- Images: WebP (multiple qualities), AVIF
- Videos: H.264 (multiple bitrates), VP9, AV1
- Thumbnails: WebP, 100x100, 300x300, 600x600

#### Dependencies

- S3-compatible storage (media storage)
- Postgres (media metadata)
- AI Models (caption generation, etc.)

#### Scaling

- **Horizontal**: Multiple worker instances
- **Queue-Based**: Media processing queue (Redis)
- **Resource-Intensive**: GPU acceleration for transcoding

---

### 4. Identity Node

**Technology**: TypeScript
**Port**: 3003
**Protocol**: HTTP/1.1, AT Protocol

#### Responsibilities

- **DID Management**: Create, resolve, and manage DIDs
- **Repository Signing**: Sign and verify repository operations
- **PLC Registry**: Interact with Portable Contacts List registry
- **AT Protocol Compliance**: Implement AT Protocol specifications
- **Key Management**: Generate and manage cryptographic keys

#### Endpoints

```
POST /api/v1/dids              - Create a new DID
GET  /api/v1/dids/:did        - Resolve a DID
POST /api/v1/repos/:did       - Repository operation
GET  /api/v1/plc/:handle      - Resolve handle to DID
POST /api/v1/keys             - Key generation and management
```

#### AT Protocol Implementation

**Repositories:**
- Each user has a repository (repo) identified by DID
- Repo contains all user data (posts, follows, etc.)
- All operations signed with user's key

**Data Models:**
```
repo.atproto.social.post        - User post
repo.atproto.social.follow     - Follow relationship
repo.atproto.social.like       - Like/reaction
repo.atproto.profile.basic     - User profile
repo.atproto.identity.signing  - Signing keys
```

**Lexicons:**
- Define data structures and validation rules
- Versioned for backward compatibility
- Shared across all AT Protocol implementations

#### Dependencies

- Postgres (DID to handle mapping, keys)
- PLC Registry (handle to DID mapping)
- AT Protocol Network (federation)

#### Scaling

- **Horizontal**: Multiple instances
- **Sharded**: By DID prefix
- **Stateless**: All state in external stores

---

## 🔄 Service Communication

### Communication Patterns

#### 1. Synchronous HTTP

**Use Case**: Request-response interactions
**Protocol**: HTTP/1.1
**Format**: JSON
**Timeout**: 5 seconds

**Example:**
```
Client → Gateway → Feed Service (synchronous)
```

#### 2. gRPC

**Use Case**: High-performance, low-latency internal communication
**Protocol**: HTTP/2
**Format**: Protocol Buffers
**Timeout**: 10 seconds

**Example:**
```
Gateway → Feed Service (gRPC for ranking)
```

#### 3. WebSocket

**Use Case**: Real-time updates to clients
**Protocol**: WebSocket
**Format**: JSON
**Timeout**: N/A (persistent connection)

**Example:**
```
Gateway → Client (real-time notifications)
```

#### 4. Redis Pub/Sub

**Use Case**: Event-driven communication between services
**Protocol**: Redis
**Format**: JSON
**Timeout**: N/A (fire-and-forget)

**Example:**
```
Feed Service → Redis (new post event)
Redis → Gateway (push to followers)
```

#### 5. Message Queue

**Use Case**: Async processing, guaranteed delivery
**Protocol**: Redis Streams
**Format**: JSON
**Timeout**: Configurable per queue

**Example:**
```
Media Service → Redis Queue (transcode job)
Worker → Redis Queue (process job)
```

### Communication Matrix

| From \ To | Gateway | Feed | Media | Identity |
|-----------|---------|------|-------|----------|
| Gateway   | -       | gRPC | HTTP  | HTTP     |
| Feed      | HTTP    | -    | -     | -        |
| Media     | HTTP    | -    | -     | -        |
| Identity  | HTTP    | -    | -     | -        |

---

## 📊 Service Dependencies

### Dependency Graph

```
┌─────────────┐
│   Client    │
└──────┬──────┘
       │
       ▼
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│  Gateway    │────▶│ Feed Service│     │ Media Service│
└──────┬──────┘     └──────┬──────┘     └──────┬──────┘
       │                    │                    │
       ▼                    ▼                    ▼
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│  Identity   │     │  Postgres    │     │     S3      │
│   Node      │     └──────┬──────┘     └─────────────┘
└─────────────┘            │
                           ▼
                    ┌─────────────┐
                    │   Redis     │
                    └──────┬──────┘
                           │
                           ▼
                    ┌─────────────┐
                    │  Pinecone   │
                    └─────────────┘
```

### Service Dependencies Table

| Service | Dependencies | Critical |
|---------|--------------|----------|
| Gateway | Postgres, Redis, Feed, Media, Identity | Yes |
| Feed | Postgres, Pinecone, Redis | Yes |
| Media | S3, Postgres, AI Models | Yes |
| Identity | Postgres, PLC Registry | Yes |

---

## 🔧 Service Configuration

### Environment Variables

Each service has its own `.env` file with the following pattern:

```env
# Service Configuration
NODE_ENV=production
PORT=3000
LOG_LEVEL=info

# Database
DATABASE_URL=postgresql://user:password@localhost:5432/kyron

# Redis
REDIS_URL=redis://localhost:6379

# External Services
PINECONE_API_KEY=xxx
PINECONE_ENVIRONMENT=us-west1-gcp
S3_ENDPOINT=https://s3.amazonaws.com
S3_ACCESS_KEY_ID=xxx
S3_SECRET_ACCESS_KEY=xxx

# Authentication
JWT_SECRET=xxx
JWT_EXPIRES_IN=24h

# Rate Limiting
RATE_LIMIT_REQUESTS=1000
RATE_LIMIT_WINDOW=60000
```

### Configuration Management

**Development:**
- Local `.env` files
- Docker Compose for dependencies

**Production:**
- Kubernetes ConfigMaps and Secrets
- Environment variables in container
- Secrets management (Vault, AWS Secrets Manager)

---

## 📈 Service Metrics

### Key Metrics per Service

#### Gateway
- Request rate (requests/second)
- Error rate (% of requests)
- Latency (P50, P95, P99)
- WebSocket connections
- Authentication failures

#### Feed Service
- Embedding generation time
- Ranking time
- Feed construction time
- Cache hit rate
- Redis stream lag

#### Media Service
- Transcoding time
- Thumbnail generation time
- Upload success rate
- Storage usage
- Processing queue length

#### Identity Node
- DID resolution time
- Repository operation time
- Key generation time
- AT Protocol compliance

---

## 🚨 Service Health Checks

### Liveness Probes

```yaml
# Kubernetes example
livenessProbe:
  httpGet:
    path: /health/live
    port: 3000
  initialDelaySeconds: 30
  periodSeconds: 10
  failureThreshold: 3
```

### Readiness Probes

```yaml
readinessProbe:
  httpGet:
    path: /health/ready
    port: 3000
  initialDelaySeconds: 5
  periodSeconds: 5
  failureThreshold: 1
```

### Health Check Endpoints

```
GET /health/live     - Service is running
GET /health/ready    - Service can accept requests
GET /health         - Full health status with dependencies
```

---

## 📚 Best Practices

### Service Design Principles

1. **Single Responsibility**: Each service does one thing well
2. **Stateless**: Avoid local state, use external stores
3. **Idempotent**: Operations should be idempotent where possible
4. **Resilient**: Handle failures gracefully, retry appropriately
5. **Observable**: Comprehensive logging, metrics, tracing
6. **Documented**: Clear API documentation, examples
7. **Versioned**: API versioning for backward compatibility

### Communication Best Practices

1. **Use Async for Long Operations**: Don't block request threads
2. **Implement Timeouts**: Always have timeouts for external calls
3. **Retry with Backoff**: Exponential backoff for transient failures
4. **Circuit Breakers**: Prevent cascading failures
5. **Bulkhead Isolation**: Isolate critical operations
6. **Rate Limiting**: Protect against abuse
7. **Validation**: Validate all inputs and outputs

### Error Handling

1. **Standard Error Formats**: Consistent error responses
2. **Appropriate HTTP Codes**: Use correct status codes
3. **Error Logging**: Log errors with context
4. **Error Metrics**: Track error rates and types
5. **Graceful Degradation**: Provide fallback behavior

---

## 🔗 References

- [Kyron Architecture Overview](OVERVIEW.md)
- [AT Protocol Specification](https://atproto.com/specs/)
- [Microservices Patterns](https://microservices.io/patterns/)
- [12 Factor App](https://12factor.net/)

---

*"Small services, loosely coupled, independently deployable."*

**Microservices Documentation** — Version 1.0 — Kyron Design System
