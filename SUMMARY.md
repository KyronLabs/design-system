# Kyron Design System - Executive Summary

## 🎯 The Vision

Kyron is building a **user-owned social stack** that combines:
- TikTok-grade discovery (vector ranking)
- Instagram AR capabilities (30fps camera with lenses)
- YouTube shelf-life (content longevity)
- Bluesky portability (AT Protocol, portable identity)

This design system unifies all these capabilities under a single, coherent design language.

---

## 🏗️ System Architecture Overview

### The Stack

```
┌─────────────────────────────────────────────────────────────┐
│                    CLIENT LAYER                                │
│  ┌─────────────────────────────────────────────────────┐    │
│  │  Flutter (iOS/Android/Web)                             │    │
│  │  - AR Camera (30fps with lenses)                     │    │
│  │  - Vector Cache (offline-first)                      │    │
│  │  - UI Components (Bluesky ALF-based)                │    │
│  └─────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
                              │
        GraphQL + WebSocket     │     gRPC
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                 API GATEWAY (NestJS)                          │
│  - Authentication & Authorization                           │
│  - Request Routing & Rate Limiting                          │
│  - WebSocket Connection Management                         │
└─────────────────────────────────────────────────────────────┘
        ┌───────────────────┬───────────────────┐
        ▼                   ▼                   ▼
┌───────────────┐   ┌───────────────┐   ┌───────────────┐
│  FEED SERVICE  │   │  MEDIA SERVICE │   │ IDENTITY NODE  │
│  - Embeddings  │   │  - Transcode   │   │  - DID        │
│  - Ranking     │   │  - Thumbnail   │   │  - Repo Sign  │
│  - Redis Stream│   │  - AI Caption  │   │  - PLC Registry│
└───────────────┘   └───────────────┘   └───────────────┘
        ┌───────────────────┬───────────────────┐
        ▼                   ▼
┌─────────────────────────────────┬─────────────────────────┐
│      INFRASTRUCTURE              │     EXTERNAL SERVICES     │
│  ┌─────────┐  ┌─────────┐       │  ┌─────────────────┐     │
│  │Postgres │  │  Redis  │       │  │   Pinecone      │     │
│  └─────────┘  └─────────┘       │  │ (Vector Search)  │     │
│                                  │  └─────────────────┘     │
│  ┌─────────────────────────────┐ │                         │
│  │     S3-Compatible Storage     │ │                         │
│  └─────────────────────────────┘ │                         │
└─────────────────────────────────┴─────────────────────────┘
```

### Design Principles

1. **Microservice Pattern**: Each service has a single responsibility
2. **Event-Driven**: Redis Streams for real-time fan-out
3. **Offline-First**: Client-side caching for resilience
4. **Portable Identity**: AT Protocol for user-owned data

### Data Flow Example: Post Upload

```
1. Client → Gateway (JWT authentication)
2. Gateway → Media Service (signed URL generation)
3. Client → S3 (direct upload)
4. Media Service → S3 (transcode, generate thumbnails)
5. Media Service → AI (generate captions, embeddings)
6. Media Service → Feed Service (store embeddings)
7. Feed Service → Redis Stream (fan-out to followers)
8. Gateway → Followers (WebSocket push notification)
```

---

## 🎨 Design Language Overview

### Bluesky ALF Foundation

We adopt **Bluesky's ALF (Application Layout Framework)** as our design foundation because:
- Proven at scale (Bluesky social network)
- Consistent across light/dim/dark themes
- Fractional precision (no rounding of values)
- Zero tracking (clean typography)
- Flat, hairline-separated interfaces

### Core Design Tokens

#### Color System

**4 Ramps × 13-15 Steps = Complete Palette**

| Ramp | Purpose | Light Theme | Dark Theme |
|------|---------|-------------|-------------|
| `contrast` | Backgrounds, text, borders | `#FFFFFF` → `#000000` | `#000000` → `#FFFFFF` (inverted) |
| `primary` | Accent, links, actions | `#006AFF` (500) | Same (inverted ramp) |
| `positive` | Success states, upvotes | Green ramp | Green ramp (inverted) |
| `negative` | Errors, downvotes, destructive | Red ramp | Red ramp (inverted) |

**3 Themes:**
- **Light**: `DEFAULT_PALETTE`, background `#FFFFFF`
- **Dim**: `invertPalette(DEFAULT_SUBDUED_PALETTE)`, background `#151D28`
- **Dark**: `invertPalette(DEFAULT_PALETTE)`, background `#000000` (OLED black)

#### Typography

**Modular Scale: 1.125 ratio from 15px base**

```
9.4, 11.3, 13.1, 15, 16.9, 18.8, 20.6, 24.3, 30, 37.5
```

**Weights:** 400, 500, 600, 700
**Tracking:** 0 (zero everywhere)
**Line Heights:** tight (1.15), snug (1.3), relaxed (1.5)

#### Spacing

**Scale:** 2, 4, 8, 12, 16, 20, 24, 28, 32, 40

#### Radius

**Scale:** 2, 4, 8, 12, 16, 20, 999 (full pill)

---

## 🖥️ Frontend Design System

### Interface Style

**Flat & Hairline-Separated**
- No elevated cards
- No shadows for separation
- 1px `border_contrast_low` hairlines run full-bleed
- Separation through lines, not depth

### Button System

**Geometry (from Bluesky Button.tsx):**

| Size | Padding V | Padding H | Gap | Text Size | Text Weight |
|------|-----------|-----------|-----|-----------|-------------|
| Large | 12 | 24 | 6 | 15 | Medium (500) |
| Small | 8 | 14 | 5 | 13.1 | Medium (500) |
| Tiny | 5 | 10 | 3 | 11.3 | Semibold (600) |

**Shape:** Fully rounded pills (`radius.full` = 999)

**Color Variants:**
- Solid Primary: `primary_500` → `primary_600` (pressed) → `primary_200` (disabled)
- Solid Secondary: `contrast_50` → `contrast_100`
- Solid Negative: `negative_500` → `negative_600`

### Navigation Pattern

**5-Tab Bottom Shell** (Bluesky model):
- Tabs: Home · Activity · News · Notifications · Profile
- Always visible, translucent
- 1px top hairline separator
- Inactive icons: linear weight
- Active icons: bold weight
- Labels hidden (icon-only)

**Icon Pairing:**
- `Iconsax.x` (bold) = active
- `Iconsax.x_copy` (linear) = inactive

### Sheet Philosophy

**Bottom Sheets Over Dialogs**
- Every confirmation, picker, form, menu = bottom sheet
- Grab handle on top
- 20px top corner radius
- No centered alert dialogs on mobile

### Thread System

**Reply Anatomy (Threads-style):**

```
ThreadGeometry:
- indent: 30 (one avatar radius + gutter)
- thickness: 2 (1px too thin, reads as hairline)
- corner: 12 (half the indent, quarter-circle turns)
- maxIndent: 4 (prevents running off screen)
```

**Three Separate Concerns:**
1. **Layout**: Which rows exist and in what order (`buildThreadLayout`)
2. **Geometry**: Where the lines go (`ThreadConnectorPlan.forRow`)
3. **Painting**: How to draw the plan (`ThreadConnectorPainter`)

**Nesting:** Unbounded, but capped at maxIndent (4 levels)

---

## ⚡ Haptics System

### Core Finding from Bluesky

```typescript
// Users said the medium impact was too strong on Android; see APP-537
const style = isIOS ? ImpactFeedbackStyle[strength] : ImpactFeedbackStyle.Light
```

**Android clamps every impact to Light.** This is critical.

### Implementation Rules

1. **Android Clamping**: All impacts → Light on Android
2. **Rate Limiting**: Micro-haptics throttled to 1 pulse per 40ms
3. **Timing**: Fire on touch-down, not tap-up (perceived latency)
4. **Compound Patterns**: 90ms minimum gap between pulses
5. **User Control**: Haptics are user-disableable
6. **Platform Awareness**: Suppressed entirely on web

### Durations

| Type | Duration | Use Case |
|------|----------|----------|
| Micro | 90ms | Press-state changes |
| Fast | 180ms | Sheets closing, chips |
| Normal | 260ms | Page pushes, sheet opening |
| Slow | 420ms | Hero animations, count-up |

---

## 🎭 Motion System

### Press Interaction

**Scale + Opacity (not Material ripple)**
- Scale: 0.97
- Opacity: 0.85
- Splash factory: NoSplash (ripples disabled app-wide)

### Navigation Transitions

- **Push (stack)**: Platform-native (iOS slide, Android predictive-back)
- **Tab Switch**: Cross-fade with no travel
- **Sheet Open**: Normal (260ms) with parallax on outgoing screen
- **Sheet Close**: Fast (180ms)

---

## 🎯 Component Philosophy

### Link Previews

**Parse with regex over `<head>`** (not full HTML parser):
- Only need 4 `<meta>` tags
- Stop at `</head>`
- Only first link gets a card (if post has no picture)
- Show host (can't be dressed up by page)
- No skeleton — wait for metadata or show nothing

### Reactions System

**The Rule: Finger drives the screen, network follows**

1. Tap updates local state immediately
2. Write is coalesced (10 rapid taps = 1 request with final state)
3. Max 1 request per content piece outstanding
4. Refetch never overwrites user's current interaction

**Optimistic Updates:**
- `ReactionTally.toggled` produces the server's final row
- Rolled back if write fails
- Realtime updates coalesced (350ms)

### Post Sharing

**Paint to canvas, don't screenshot:**
- Screenshot fails (clipped, has chrome, needs mounted widget)
- Explicit painting = pure function of NewsPost
- Link goes in share text (not image) — targets linkify text
- Link points to `AppConfig.appUrl` (only Kyron address for non-users)

---

## 🌈 Brand Identity

### Color Philosophy

**Accent:** `#006AFF` (primary_500) — The Bluesky blue
**Light Theme:** Clean, airy, professional
**Dark Theme:** True black (`#000000`) for OLED, dim (`#151D28`) as default
**Dim Theme:** Subdued palette for reduced eye strain

### Typography

**Font Family:** Inter (as in current implementation)
**Zero Tracking:** No negative letter-spacing anywhere
**Fractional Sizes:** Preserve 15, 16.9, 18.8... (don't round to 14/16/18)

### Iconography

**Iconsax Flutter ^1.0.1**
- 1,025 glyphs × 2 weights (bold, linear)
- No Material Icons anywhere
- Active = bold, Inactive = linear

### SVG Assets

**Rules:**
1. All SVGs paint in `currentColor`
2. Tint at call site with `ColorFilter`
3. No hard-coded fills (e.g., `fill="#000000"`)
4. Optimize for size (hero_dots.svg → hero_glow.svg: 28KB → 1KB)

---

## ♿ Accessibility

### Core Principles

1. **Color Contrast**: Minimum 4.5:1 for text
2. **Touch Targets**: Minimum 44×44pt
3. **Reduced Motion**: Respect system preferences
4. **Screen Reader**: All interactive elements labeled
5. **Focus Management**: Clear focus indicators

### Implementation

- Semantics for all interactive widgets
- High contrast mode support
- Dynamic type support
- VoiceOver/TalkBack tested

---

## 🧪 Testing Standards

### Design System Testing

1. **Token Tests**: Verify color values, spacing, typography
2. **Component Tests**: Widget tests for all components
3. **Layout Tests**: Assert on geometry (thread connectors, etc.)
4. **Interaction Tests**: Verify haptic timing, motion durations

### Key Test Files (from Omnia implementation)

- `test/thread_model_test.dart` - Thread layout logic
- `test/thread_layout_test.dart` - Thread geometry
- `test/reactions_notifier_test.dart` - Reaction state management
- `test/history_headers_test.dart` - Sticky day headers

---

## 📈 Performance Standards

### Targets

- **Feed P95**: < 300ms
- **AR Camera**: 30fps sustained
- **Page Load**: < 1s on cold start
- **Interaction**: < 100ms response time
- **Animation**: 60fps on all devices

### Optimization Strategies

1. **Vector Cache**: Offline-first with efficient storage
2. **Image Optimization**: Transcode, thumbnail, lazy load
3. **Debouncing**: Coalesce rapid user actions
4. **Preloading**: Prefetch next screens
5. **Memory**: Limit cache sizes, proper disposal

---

## 🎨 Design System Evolution

### Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2024-XX-XX | Initial system based on Omnia/Bluesky ALF |

### Future Enhancements

1. **Design Token Tooling**: Automated token generation
2. **Component Library**: Shared Flutter package
3. **Web Implementation**: HTML/CSS token export
4. **Figma Integration**: Design tokens in Figma
5. **Accessibility Audit**: Comprehensive WCAG compliance

---

## 📚 References

### Source Materials

1. **Bluesky ALF**: `@bsky.app/alf@0.1.15` — `src/palette.ts`, `src/tokens.ts`
2. **Omnia Wallet**: Existing Flutter implementation
3. **Kyron Architecture**: `ARCHITECTURE.md` in main repo
4. **Folder Structure**: `FOLDER_STRUCTURE.md` in main repo

### Related Documentation

- [Kyron Main README](https://github.com/KyronLabs/kyron#readme)
- [Architecture Diagram](https://github.com/KyronLabs/kyron/blob/main/docs/architecture.png)
- [Contributing Guide](https://github.com/KyronLabs/kyron/blob/main/CONTRIBUTING.md)

---

*"Consistency is the foundation of great design."*

**Kyron Design System** — Version 1.0 — Built by [KyronLabs](https://github.com/KyronLabs)
