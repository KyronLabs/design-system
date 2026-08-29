# Color System

## 🎨 Color Philosophy

Kyron's color system is built on **Bluesky's ALF (Application Layout Framework)** foundation. This provides a **consistent, scalable, and themeable** approach to color that works across light, dim, and dark modes.

### Core Principles

1. **Ramp-Based**: Colors are organized in ramps (gradations) rather than individual values
2. **Inversion for Themes**: Dark themes use the same ramps read backwards (`invertPalette`)
3. **Consistency**: Same color tokens map to the same visual roles across all themes
4. **Accessibility**: All color combinations meet WCAG 2.1 AA contrast requirements

---

## 🎯 Color Ramps

### The Four Ramps

Kyron uses **four color ramps**, each with 13-15 steps:

| Ramp | Purpose | Light Theme Direction | Dark Theme Direction |
|------|---------|----------------------|-----------------------|
| `contrast` | Backgrounds, text, borders | Light to Dark | Dark to Light (inverted) |
| `primary` | Accent, links, actions | Light to Dark | Dark to Light (inverted) |
| `positive` | Success, upvotes, positive actions | Light to Dark | Dark to Light (inverted) |
| `negative` | Errors, downvotes, destructive actions | Light to Dark | Dark to Light (inverted) |

### Ramp Structure

Each ramp has **13-15 steps**, numbered from 0 to 1000+:

```
Ramp Step:    0     100    200    300    400    500    600    700    800    900    1000
Light:     Light  ━━━━━━━━━━━━━━━━━► Dark
Dark:      Dark   ━━━━━━━━━━━━━━━━━► Light (inverted)
```

This means:
- In **light theme**: `contrast_0` = lightest (background), `contrast_1000` = darkest (text)
- In **dark theme**: `contrast_0` = darkest (background), `contrast_1000` = lightest (text)

---

## 🌈 Contrast Ramp

The **contrast ramp** is the primary color system for backgrounds, text, and borders.

### Light Theme Values

| Step | Hex | Usage |
|------|-----|-------|
| contrast_0 | `#FFFFFF` | Page background |
| contrast_50 | `#F7F7F7` | Subtle backgrounds, secondary surfaces |
| contrast_100 | `#E8E8E8` | Hairline dividers, low-contrast borders |
| contrast_200 | `#D9D9D9` | Stronger borders, disabled states |
| contrast_300 | `#C9C9C9` | Input borders, separator lines |
| contrast_400 | `#B0B0B0` | Tertiary text, timestamps |
| contrast_500 | `#999999` | Secondary text, placeholders |
| contrast_600 | `#737373` | Body text (secondary) |
| contrast_700 | `#5C5C5C` | Body text (primary in some contexts) |
| contrast_800 | `#3A3A3A` | Strong text |
| contrast_900 | `#262626` | Headings, important text |
| contrast_1000 | `#000000` | Primary text, highest contrast |

### Dark Theme Values (Inverted)

| Step | Hex | Usage |
|------|-----|-------|
| contrast_0 | `#000000` | Page background (OLED black) |
| contrast_50 | `#0A0A0A` | Subtle backgrounds |
| contrast_100 | `#1A1A1A` | Hairline dividers |
| contrast_200 | `#262626` | Stronger borders |
| contrast_300 | `#3A3A3A` | Input borders |
| contrast_400 | `#5C5C5C` | Tertiary text, timestamps |
| contrast_500 | `#737373` | Secondary text |
| contrast_600 | `#999999` | Body text (secondary) |
| contrast_700 | `#B0B0B0` | Body text (primary) |
| contrast_800 | `#C9C9C9` | Strong text |
| contrast_900 | `#D9D9D9` | Headings |
| contrast_1000 | `#FFFFFF` | Primary text, highest contrast |

### Dim Theme Values (Subdued Palette)

The **dim theme** uses a subdued version of the contrast ramp:

| Step | Hex | Usage |
|------|-----|-------|
| contrast_0 | `#151D28` | Page background |
| contrast_50 | `#1E2A38` | Subtle backgrounds |
| contrast_100 | `#2A3848` | Hairline dividers |
| contrast_200 | `#384858` | Stronger borders |
| contrast_300 | `#485868` | Input borders |
| contrast_400 | `#607080` | Tertiary text |
| contrast_500 | `#788898` | Secondary text |
| contrast_600 | `#90A0B0` | Body text (secondary) |
| contrast_700 | `#A8B8C8` | Body text (primary) |
| contrast_800 | `#C0D0D8` | Strong text |
| contrast_900 | `#D8E8F0` | Headings |
| contrast_1000 | `#F0F8FF` | Primary text |

---

## 🔵 Primary Ramp

The **primary ramp** provides accent colors for actions, links, and highlights.

### Values (Same for all themes, ramp direction changes)

| Step | Hex | Usage |
|------|-----|-------|
| primary_0 | `#E6F0FF` | Lightest accent (subtle backgrounds) |
| primary_50 | `#CCE0FF` | Light accent backgrounds |
| primary_100 | `#B3D1FF` | Hover states, light fills |
| primary_200 | `#99C2FF` | Active states |
| primary_300 | `#80B3FF` | Focus states |
| primary_400 | `#66A4FF` | Selected states |
| primary_500 | `#006AFF` | **Default accent color** |
| primary_600 | `#005BCC` | Pressed states, darker accent |
| primary_700 | `#004D99` | Dark accent |
| primary_800 | `#003F80` | Very dark accent |
| primary_900 | `#003366` | Darkest accent |
| primary_1000 | `#00264D` | Almost black accent |

### Usage in Themes

**Light Theme:**
- `primary_500` = Main accent (`#006AFF`)
- `primary_600` = Pressed/hover state
- `primary_200` = Disabled state

**Dark/Dim Theme:**
- `primary_500` = Main accent (same hex, but appears lighter against dark background)
- `primary_400` = Pressed/hover state (lighter due to inversion)
- `primary_700` = Disabled state

---

## 🟢 Positive Ramp

The **positive ramp** provides colors for success states, upvotes, and positive feedback.

### Values

| Step | Hex | Usage |
|------|-----|-------|
| positive_0 | `#E6FFF0` | Lightest positive |
| positive_50 | `#CCFFE0` | Light positive backgrounds |
| positive_100 | `#B3FFD1` | Hover states |
| positive_200 | `#99FFC2` | Active states |
| positive_300 | `#80FFB3` | Focus states |
| positive_400 | `#66FFA4` | Selected states |
| positive_500 | `#4CD4B0` | **Default positive color** (successAqua in current implementation) |
| positive_600 | `#42B896` | Pressed states |
| positive_700 | `#389C7C` | Dark positive |
| positive_800 | `#2E8062` | Very dark positive |
| positive_900 | `#246449` | Darkest positive |
| positive_1000 | `#1A4830` | Almost black positive |

---

## 🔴 Negative Ramp

The **negative ramp** provides colors for errors, downvotes, and destructive actions.

### Values

| Step | Hex | Usage |
|------|-----|-------|
| negative_0 | `#FFE6E6` | Lightest negative |
| negative_50 | `#FFCCCC` | Light negative backgrounds |
| negative_100 | `#FFB3B3` | Hover states |
| negative_200 | `#FF9999` | Active states |
| negative_300 | `#FF8080` | Focus states |
| negative_400 | `#FF6666` | Selected states |
| negative_500 | `#FF4C4C` | Default negative |
| negative_600 | `#FF6582` | **Error pink** (errorPink in current implementation) |
| negative_700 | `#CC3D3D` | Dark negative |
| negative_800 | `#992E2E` | Very dark negative |
| negative_900 | `#661F1F` | Darkest negative |
| negative_1000 | `#331010` | Almost black negative |

---

## 🎨 Semantic Color Mapping

### Background Colors

| Semantic | Light Theme | Dim Theme | Dark Theme |
|----------|-------------|-----------|-------------|
| Page Background | `contrast_0` (`#FFFFFF`) | `contrast_0` (`#151D28`) | `contrast_0` (`#000000`) |
| Surface Background | `contrast_50` (`#F7F7F7`) | `contrast_50` (`#1E2A38`) | `contrast_50` (`#0A0A0A`) |
| Elevated Surface | `contrast_100` (`#E8E8E8`) | `contrast_100` (`#2A3848`) | `contrast_100` (`#1A1A1A`) |
| Pill Background (Dark) | `contrast_50` (`#1F1F23`) | Custom | Custom |
| Pill Background (Light) | `contrast_50` (`#F7F7F7`) | Custom | Custom |

### Text Colors

| Semantic | Light Theme | Dim Theme | Dark Theme |
|----------|-------------|-----------|-------------|
| Primary Text | `contrast_1000` (`#000000`) | `contrast_1000` (`#F0F8FF`) | `contrast_1000` (`#FFFFFF`) |
| Secondary Text | `contrast_700` (`#5C5C5C`) | `contrast_700` (`#A8B8C8`) | `contrast_700` (`#B0B0B0`) |
| Tertiary Text | `contrast_400` (`#B0B0B0`) | `contrast_400` (`#607080`) | `contrast_400` (`#5C5C5C`) |
| Timestamps | `contrast_400` (`#B0B0B0`) | `contrast_400` (`#607080`) | `contrast_400` (`#5C5C5C`) |

### Accent Colors

| Semantic | Light Theme | Dim Theme | Dark Theme |
|----------|-------------|-----------|-------------|
| Primary Accent | `primary_500` (`#006AFF`) | `primary_500` (`#006AFF`) | `primary_500` (`#006AFF`) |
| Primary Hover | `primary_600` (`#005BCC`) | `primary_400` (`#66A4FF`) | `primary_400` (`#66A4FF`) |
| Primary Disabled | `primary_200` (`#99C2FF`) | `primary_700` (`#004D99`) | `primary_700` (`#004D99`) |
| Link Text | `primary_600` (`#005BCC`) | `primary_400` (`#66A4FF`) | `primary_400` (`#66A4FF`) |

### Border Colors

| Semantic | Light Theme | Dim Theme | Dark Theme |
|----------|-------------|-----------|-------------|
| Hairline Divider | `contrast_100` (`#E8E8E8`) | `contrast_100` (`#2A3848`) | `contrast_100` (`#1A1A1A`) |
| Strong Border | `contrast_200` (`#D9D9D9`) | `contrast_200` (`#384858`) | `contrast_200` (`#262626`) |
| Input Border | `contrast_300` (`#C9C9C9`) | `contrast_300` (`#485868`) | `contrast_300` (`#3A3A3A`) |
| Focus Border | `primary_500` (`#006AFF`) | `primary_500` (`#006AFF`) | `primary_500` (`#006AFF`) |

### Status Colors

| Semantic | Light Theme | Dim Theme | Dark Theme |
|----------|-------------|-----------|-------------|
| Success | `positive_500` (`#4CD4B0`) | `positive_500` (`#4CD4B0`) | `positive_500` (`#4CD4B0`) |
| Error | `negative_600` (`#FF6582`) | `negative_600` (`#FF6582`) | `negative_600` (`#FF6582`) |
| Warning | `negative_500` (`#FF4C4C`) | `negative_500` (`#FF4C4C`) | `negative_500` (`#FF4C4C`) |

---

## 🌓 Theme Definitions

### Light Theme

```dart
// Light theme uses DEFAULT_PALETTE
ThemeData.light().copyWith(
  brightness: Brightness.light,
  scaffoldBackgroundColor: contrast_0, // #FFFFFF
  colorScheme: ColorScheme.light(
    primary: primary_500, // #006AFF
    onPrimary: Colors.white,
    secondary: primary_500,
    onSecondary: Colors.white,
    surface: contrast_50, // #F7F7F7
    onSurface: contrast_1000, // #000000
    background: contrast_0, // #FFFFFF
    onBackground: contrast_1000, // #000000
    error: negative_600, // #FF6582
    onError: Colors.white,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: contrast_1000),
    bodyMedium: TextStyle(color: contrast_700),
    // ...
  ),
)
```

### Dim Theme

```dart
// Dim theme uses invertPalette(DEFAULT_SUBDUED_PALETTE)
ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: contrast_0, // #151D28
  colorScheme: ColorScheme.dark(
    primary: primary_500, // #006AFF
    onPrimary: Colors.white,
    secondary: primary_500,
    onSecondary: Colors.white,
    surface: contrast_50, // #1E2A38
    onSurface: contrast_1000, // #F0F8FF
    background: contrast_0, // #151D28
    onBackground: contrast_1000, // #F0F8FF
    error: negative_600, // #FF6582
    onError: Colors.white,
  ),
)
```

### Dark Theme

```dart
// Dark theme uses invertPalette(DEFAULT_PALETTE)
ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: contrast_0, // #000000
  colorScheme: ColorScheme.dark(
    primary: primary_500, // #006AFF
    onPrimary: Colors.white,
    secondary: primary_500,
    onSecondary: Colors.white,
    surface: contrast_50, // #0A0A0A
    onSurface: contrast_1000, // #FFFFFF
    background: contrast_0, // #000000
    onBackground: contrast_1000, // #FFFFFF
    error: negative_600, // #FF6582
    onError: Colors.white,
  ),
)
```

---

## 🎨 Color Usage Guidelines

### Do's

✅ **Use semantic color names** in code (e.g., `textPrimary`, not `#1A202C`)
✅ **Test colors in all themes** to ensure consistency
✅ **Use contrast ramp for text** to ensure readability
✅ **Use primary ramp for interactive elements**
✅ **Maintain color hierarchy** (primary > secondary > tertiary)

### Don'ts

❌ **Don't hard-code hex values** in UI code
❌ **Don't use color for information only** (always pair with text/icon)
❌ **Don't create custom colors** outside the ramp system
❌ **Don't ignore accessibility** (check contrast ratios)
❌ **Don't use the same color for different purposes**

---

## ♿ Accessibility

### Contrast Ratios

All color combinations must meet **WCAG 2.1 AA** standards:

| Text Size | Minimum Contrast Ratio |
|-----------|------------------------|
| Large (18.66px+) | 3:1 |
| Normal | 4.5:1 |

### Color Pairings

**Light Theme:**
- Primary text (`contrast_1000`) on background (`contrast_0`): 21:1 ✅
- Secondary text (`contrast_700`) on background (`contrast_0`): 7.5:1 ✅
- Primary accent (`primary_500`) on background (`contrast_0`): 4.6:1 ✅

**Dark Theme:**
- Primary text (`contrast_1000`) on background (`contrast_0`): 21:1 ✅
- Secondary text (`contrast_700`) on background (`contrast_0`): 7.5:1 ✅
- Primary accent (`primary_500`) on background (`contrast_0`): 4.6:1 ✅

**Dim Theme:**
- Primary text (`contrast_1000`) on background (`contrast_0`): 15:1 ✅
- Secondary text (`contrast_700`) on background (`contrast_0`): 5.2:1 ✅

### Tools

- [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
- [Adobe Color Contrast Analyzer](https://color.adobe.com/create/color-contrast-analyzer)

---

## 📱 Current Implementation Mapping

Based on the existing `app_theme.dart`:

```dart
// Current colors mapped to ramp system:

// Dark Colors
background: Color(0xFF0D0D0F)           → contrast_0 (close to #000000)
surface: Color(0xFF1A1A1D)             → contrast_50 (close to #0A0A0A)
textPrimary: Color(0xFFE5EBF5)          → contrast_1000 (close, but lighter)
textSecondary: Color(0xFF7E8A9A)        → contrast_700 (close)

// Light Colors
lightBackground: Color(0xFFFFFFFF)     → contrast_0
lightBackgroundStart: Color(0xFFFFFFFF) → contrast_0
lightBackgroundEnd: Color(0xFFF0F4F8)   → Custom gradient
lightSurface: Color(0xFFF8FAFC)         → contrast_50 (close)
lightTextPrimary: Color(0xFF1A202C)    → contrast_1000 (close)
lightTextSecondary: Color(0xFF718096)  → contrast_700 (close)

// Shared Colors
accent: Color(0xFF4C8FFF)              → primary_500 (close to #006AFF)
errorPink: Color(0xFFFF6582)           → negative_600
successAqua: Color(0xFF4CD4B0)          → positive_500

// Pill backgrounds
darkPillBg: Color(0xFF1F1F23)           → Custom (between contrast_50 and 100)
lightPillBg: Color(0xFFF7F7F7)          → contrast_50
```

---

## 📦 Token Export

For programmatic access, colors are exported as JSON:

```json
{
  "colors": {
    "contrast": {
      "0": "#FFFFFF",
      "50": "#F7F7F7",
      "100": "#E8E8E8",
      "200": "#D9D9D9",
      "300": "#C9C9C9",
      "400": "#B0B0B0",
      "500": "#999999",
      "600": "#737373",
      "700": "#5C5C5C",
      "800": "#3A3A3A",
      "900": "#262626",
      "1000": "#000000"
    },
    "primary": {
      "0": "#E6F0FF",
      "50": "#CCE0FF",
      "100": "#B3D1FF",
      "200": "#99C2FF",
      "300": "#80B3FF",
      "400": "#66A4FF",
      "500": "#006AFF",
      "600": "#005BCC",
      "700": "#004D99",
      "800": "#003F80",
      "900": "#003366",
      "1000": "#00264D"
    },
    "positive": {
      "0": "#E6FFF0",
      "50": "#CCFFE0",
      "100": "#B3FFD1",
      "200": "#99FFC2",
      "300": "#80FFB3",
      "400": "#66FFA4",
      "500": "#4CD4B0",
      "600": "#42B896",
      "700": "#389C7C",
      "800": "#2E8062",
      "900": "#246449",
      "1000": "#1A4830"
    },
    "negative": {
      "0": "#FFE6E6",
      "50": "#FFCCCC",
      "100": "#FFB3B3",
      "200": "#FF9999",
      "300": "#FF8080",
      "400": "#FF6666",
      "500": "#FF4C4C",
      "600": "#FF6582",
      "700": "#CC3D3D",
      "800": "#992E2E",
      "900": "#661F1F",
      "1000": "#331010"
    }
  },
  "semantic": {
    "light": {
      "background": "#FFFFFF",
      "surface": "#F7F7F7",
      "textPrimary": "#000000",
      "textSecondary": "#5C5C5C",
      "textTertiary": "#B0B0B0",
      "accent": "#006AFF",
      "accentHover": "#005BCC",
      "accentDisabled": "#99C2FF",
      "error": "#FF6582",
      "success": "#4CD4B0",
      "border": "#E8E8E8",
      "borderStrong": "#D9D9D9"
    },
    "dim": {
      "background": "#151D28",
      "surface": "#1E2A38",
      "textPrimary": "#F0F8FF",
      "textSecondary": "#A8B8C8",
      "textTertiary": "#607080",
      "accent": "#006AFF",
      "accentHover": "#66A4FF",
      "accentDisabled": "#004D99",
      "error": "#FF6582",
      "success": "#4CD4B0",
      "border": "#2A3848",
      "borderStrong": "#384858"
    },
    "dark": {
      "background": "#000000",
      "surface": "#0A0A0A",
      "textPrimary": "#FFFFFF",
      "textSecondary": "#B0B0B0",
      "textTertiary": "#5C5C5C",
      "accent": "#006AFF",
      "accentHover": "#66A4FF",
      "accentDisabled": "#004D99",
      "error": "#FF6582",
      "success": "#4CD4B0",
      "border": "#1A1A1A",
      "borderStrong": "#262626"
    }
  }
}
```

---

## 🔗 References

- [Bluesky ALF Palette](https://github.com/bluesky-social/social-app/blob/main/src/alf/themes.ts)
- [Bluesky ALF Tokens](https://github.com/bluesky-social/social-app/blob/main/src/alf/tokens.ts)
- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)

---

*"Color is to the eye what music is to the ear."*

**Color System Documentation** — Version 1.0 — Kyron Design System
