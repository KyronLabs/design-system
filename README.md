# Kyron Design System

## The Single Source of Truth for All Kyron Ecosystem Design

This repository contains **every system design philosophy** for the Kyron ecosystem — from system architecture to frontend design and brand identity. It serves as the comprehensive design system that unifies all Kyron products under a consistent, well-documented approach.

---

## 📁 Repository Structure

```
design-system/
├── README.md                          # This file
├── SUMMARY.md                         # Executive overview of all systems
│
├── architecture/                      # System Architecture
│   ├── OVERVIEW.md                    # High-level architecture philosophy
│   ├── microservices.md               # Service design patterns
│   ├── data-flow.md                   # Data architecture & flows
│   ├── security.md                    # Security architecture
│   └── scalability.md                 # Scaling strategies
│
├── design-tokens/                     # Core Design Tokens (Bluesky ALF-based)
│   ├── colors.md                      # Complete color system
│   ├── typography.md                  # Font scales & weights
│   ├── spacing.md                     # Space scale (2, 4, 8, 12, 16, 20, 24, 28, 32, 40)
│   ├── radius.md                      # Border radius system
│   ├── shadows.md                     # Elevation & shadows
│   └── tokens.json                    # Machine-readable token export
│
├── frontend/                          # Frontend Design System
│   ├── philosophy.md                  # Design principles & philosophy
│   ├── components/                    # Component specifications
│   │   ├── buttons.md                 # Button system (pills, sizes, states)
│   │   ├── inputs.md                  # Input fields & forms
│   │   ├── cards.md                   # Card designs
│   │   ├── sheets.md                  # Bottom sheets & dialogs
│   │   ├── navigation.md              # Navigation patterns
│   │   └── thread-connector.md        # Thread reply connectors
│   ├── layouts/                       # Layout patterns
│   │   ├── grid.md                    # Grid systems
│   │   ├── spacing.md                 # Layout spacing rules
│   │   └── responsive.md              # Responsive design
│   ├── haptics.md                     # Haptic feedback system
│   ├── motion.md                      # Animation & motion
│   └── accessibility.md               # Accessibility guidelines
│
├── brand/                             # Brand Identity
│   ├── identity.md                    # Brand identity & voice
│   ├── color-usage.md                 # Brand color applications
│   ├── typography.md                  # Brand typography
│   ├── iconography.md                 # Icon system (Iconsax)
│   ├── assets.md                      # Asset management
│   └── tone-voice.md                  # Brand tone & voice
│
├── patterns/                          # Design Patterns
│   ├── interaction.md                 # Interaction patterns
│   ├── feedback.md                    # User feedback patterns
│   ├── empty-states.md                # Empty state designs
│   ├── loading.md                     # Loading states
│   └── error-handling.md              # Error patterns
│
├── flutter/                           # Flutter-Specific Implementation
│   ├── theme.dart                     # Flutter theme implementation
│   ├── tokens.dart                    # Dart token definitions
│   ├── widgets/                       # Reusable widget patterns
│   │   ├── pressable.dart             # Press interaction widget
│   │   ├── sheet.dart                 # Bottom sheet widget
│   │   └── thread_painter.dart        # Thread connector painter
│   └── utils/                         # Flutter utilities
│       ├── haptics.dart               # Haptic feedback utilities
│       └── motion.dart                # Motion utilities
│
└── guidelines/                       # Cross-Cutting Guidelines
    ├── performance.md                 # Performance guidelines
    ├── testing.md                     # Testing standards
    ├── code-style.md                  # Code style guide
    └── contribution.md                # Contribution guidelines
```

---

## 🎯 Design Philosophy

### Core Principles

1. **Portability First**: Every design decision must support user-owned, portable identity and data
2. **Performance Obsessed**: Social apps live or die by responsiveness — every interaction must feel instant
3. **Consistency Over Customization**: Unified experience across iOS, Android, and Web
4. **Accessibility by Default**: Design for everyone from the start

### Bluesky ALF Foundation

This design system is heavily inspired by and compatible with **Bluesky's ALF (Application Layout Framework)**. The Omnia Wallet implementation proved the effectiveness of this system, and we extend it across the entire Kyron ecosystem.

---

## 📚 Quick Navigation

| Area | Description | Key Files |
|------|-------------|-----------|
| **Colors** | 4 ramp system (contrast, primary, positive, negative) with 13-15 steps each | `design-tokens/colors.md` |
| **Typography** | Fractional font scale (15px base, 1.125 modular scale) | `design-tokens/typography.md` |
| **Spacing** | 2, 4, 8, 12, 16, 20, 24, 28, 32, 40 scale | `design-tokens/spacing.md` |
| **Components** | Pill buttons, hairline-separated interfaces, bottom sheets | `frontend/components/` |
| **Haptics** | Android-clamped impacts, rate-limited micro-haptics | `frontend/haptics.md` |
| **Motion** | Short durations (90-420ms), scale+opacity press states | `frontend/motion.md` |

---

## 🚀 Getting Started

### For Designers

1. Read `SUMMARY.md` for the executive overview
2. Explore `design-tokens/` for the core visual language
3. Check `frontend/components/` for UI patterns
4. Review `brand/` for identity guidelines

### For Developers

1. Use `flutter/` for direct Flutter implementation
2. Reference `design-tokens/tokens.json` for programmatic access
3. Follow patterns in `frontend/` for consistent implementation
4. Check `guidelines/` for coding standards

---

## 📞 Support & Contribution

This is a living document. As the Kyron ecosystem evolves, so does this design system.

- **Found a gap?** Open an issue or PR
- **Need clarification?** Check existing docs or ask in Discord
- **Want to contribute?** See `guidelines/contribution.md`

---

## 🔗 Related Repositories

- [Kyron Main Repository](https://github.com/KyronLabs/kyron) - Core application code
- [Kyron API](https://github.com/KyronLabs/kyron/tree/main/api) - Backend services
- [Kyron App](https://github.com/KyronLabs/kyron/tree/main/app) - Flutter client

---

*"Design is how it works, not just how it looks."*

**Kyron Design System** — Built by [KyronLabs](https://github.com/KyronLabs)
