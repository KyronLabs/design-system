# Kyron Design System

Colour, type, spacing, radius, motion and haptics for Kyron — written down
once, and shipped as a Flutter package so applications consume it rather than
copying it.

> **What this file used to be.** It drew a directory tree of thirty-nine files.
> Twenty-two of them did not exist — `tokens.json`, `shadows.md`, `sheets.md`,
> `inputs.md`, `cards.md`, `thread-connector.md`, every file under `patterns/`,
> `layouts/` and `flutter/widgets/`, and the `guidelines/contribution.md` it
> told contributors to read. It also sent developers to
> `design-tokens/tokens.json` "for programmatic access". A README that lists
> files nobody wrote costs a reader more than no README: they go looking, and
> the absence reads as their mistake. This one lists what is here.

---

## Two platforms

Kyron runs on phones and on the desktop, and one set of rules does not fit
both. The palette, the type scale and the contrast floors are shared without
exception; targets, radii, density, motion defaults and the whole question of
how a choice is presented are not.

| | Phone | Desktop |
|---|---|---|
| Rules | [`frontend/philosophy.md`](frontend/philosophy.md) | [`desktop/philosophy.md`](desktop/philosophy.md) |
| Components | [`frontend/components/buttons.md`](frontend/components/buttons.md) | [`desktop/components.md`](desktop/components.md) |
| Consumed as | the Flutter package | [`desktop/tokens.css`](desktop/tokens.css) |
| Target floor | 44 | 24 |
| Button shape | full pill | 4px rectangle |
| A choice of options | bottom sheet | shown in place, or a popover |
| Default type | 15 | 13.1 |

`flutter/test/desktop_css_test.dart` reads `desktop/tokens.css` and fails if
any colour, size, spacing step or duration in it disagrees with the Dart, so
the two forms of the same palette cannot drift apart.

---

## What is here

### The Flutter package — `flutter/`

The part that runs. `flutter/pubspec.yaml` publishes `kyron_design_system`, which the
Kyron app depends on by git ref.

```
flutter/lib/kyron_design_system.dart   the export
flutter/lib/src/tokens.dart            fifteen token classes
flutter/lib/src/theme.dart             KyronTheme.lightTheme / .darkTheme
flutter/test/theme_test.dart           nine tests
```

```dart
import 'package:kyron_design_system/kyron_design_system.dart';

MaterialApp(theme: KyronTheme.lightTheme, darkTheme: KyronTheme.darkTheme);
```

The token classes are `ContrastRamp`, `PrimaryRamp`, `PositiveRamp`,
`NegativeRamp`, `DimContrastRamp`, `SemanticColors`, `TypographyTokens`,
`SpacingTokens`, `RadiusTokens`, `MotionTokens`, `ButtonTokens`, `ButtonSize`,
`ThreadTokens` and `HapticsTokens`.

This package exists because the Flutter client used to keep a hand-written
theme of its own, which had drifted into a separate vocabulary — `background`
where this says `darkBackground`, and nothing at all for the ALF ramps.
Copying was the only mechanism available, so drift was the only possible
outcome.

### The written system — sixteen documents

| | |
|:--|:--|
| `design-tokens/colors.md` | The four ramps — contrast, primary, positive, negative — 13–15 steps each |
| `design-tokens/typography.md` | Fractional scale, 15px base, 1.125 modular |
| `design-tokens/spacing.md` | 2, 4, 8, 12, 16, 20, 24, 28, 32, 40 |
| `design-tokens/radius.md` | The radius scale, and which shape goes where |
| `frontend/philosophy.md` | Why the interface looks the way it does |
| `frontend/components/buttons.md` | Pill buttons: sizes, kinds, states |
| `frontend/navigation.md` | Navigation and UX patterns |
| `frontend/motion.md` | 90–420ms, scale-and-opacity press states |
| `frontend/haptics.md` | Android-clamped impacts, rate-limited micro-haptics |
| `brand/identity.md` | The brand, and its voice |
| `brand/color-usage.md` | Where brand colour is allowed and where it is not |
| `guidelines/accessibility.md` | Contrast, targets, semantics, text scale |
| `guidelines/testing.md` | What a design change has to prove before it lands |
| `architecture/OVERVIEW.md` | System architecture — see the note below |
| `architecture/microservices.md` | Service design — see the note below |
| `SUMMARY.md` | Executive overview of all of the above |

### A design, not a description

`architecture/` describes a **microservice** system: an API gateway, separate
identity and media services, independent scaling and deployment.

**Kyron is not that today, deliberately.** It is one NestJS API over one
Postgres — the kyron repository's own README says so in as many words, and the
`identity/` and `media/` directories there are a Dockerfile each, for services
nobody has written. Read `architecture/` as a target somebody may or may not
still want, not as a map of what is running. Where the two disagree, the code
settles it.

---

## What is not here, and is worth knowing

- ~~No CI.~~ `.github/workflows/ci.yml` formats, analyses and tests the
  package on every push. It was added the day a `FloatingActionButton` shipped
  as a white glyph on a near-white disc, at 1.06:1, because nothing here had
  ever run.
- **No machine-readable token export.** The tokens exist twice — as prose in
  `design-tokens/` and as Dart in `flutter/lib/src/tokens.dart` — with nothing
  holding the two together. A `tokens.json` is the obvious fix and the reason
  the old README promised one.
- **`flutter/build/` and `flutter/.dart_tool/` are tracked in git.** Build
  output, committed.
- **Consumers pin a commit.** The Kyron app's `pubspec.lock` names a specific
  git ref, so a change here does not reach the app until somebody bumps it.

---

## The rest of the ecosystem

| | |
|:--|:--|
| [**kyron**](https://github.com/KyronLabs/kyron) | The app, the API and the web build |
| [**kyron-lenses**](https://github.com/KyronLabs/kyron-lenses) | The published AR lens catalogue |
| [**kyron-lens-studio**](https://github.com/KyronLabs/kyron-lens-studio) | The Windows tool for authoring lenses |
| [**kyron-live**](https://github.com/KyronLabs/kyron-live) | Live video — the costed decision, before the code |
| [**Kyron_Terms_and_Privacy**](https://github.com/KyronLabs/Kyron_Terms_and_Privacy) | The two legal pages the app links out to |

---

*"Design is how it works, not just how it looks."*
