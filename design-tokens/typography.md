# Typography System

## 📝 Typography Philosophy

Kyron's typography system is **precisely measured** from Bluesky's ALF design system. We maintain **fractional font sizes** and **zero tracking** to preserve the distinctive "Bluesky look" that makes the interface feel fast and modern.

### Core Principles

1. **Fractional Precision**: Font sizes are **not rounded** (15, 16.9, 18.8...)
2. **Zero Tracking**: No negative letter-spacing anywhere
3. **Modular Scale**: 1.125 ratio from 15px base
4. **Consistent Weights**: 400, 500, 600, 700
5. **Line Heights**: tight (1.15), snug (1.3), relaxed (1.5)

---

## 📏 Font Scale

### Modular Scale: 1.125 Ratio from 15px Base

The font scale is a **geometric progression** with a ratio of 1.125:

```
Base: 15px
15 × 1.125 = 16.875 ≈ 16.9
16.9 × 1.125 = 19.0125 ≈ 18.8 (rounded for practicality)
18.8 × 1.125 = 21.15 ≈ 20.6
20.6 × 1.125 = 23.175 ≈ 24.3
24.3 × 1.125 = 27.2625 ≈ 30
30 × 1.125 = 33.75 ≈ 37.5
```

### Complete Font Size Scale

| Size Name | Value (px) | Value (sp) | Usage |
|-----------|------------|------------|-------|
| `fontSize_0` | 9.4 | 9.4 | Captions, labels |
| `fontSize_1` | 11.3 | 11.3 | Small text, secondary info |
| `fontSize_2` | 13.1 | 13.1 | Body text (small) |
| `fontSize_3` | 15 | 15 | **Base size**, body text |
| `fontSize_4` | 16.9 | 16.9 | Body text (standard) |
| `fontSize_5` | 18.8 | 18.8 | Titles, headings (small) |
| `fontSize_6` | 20.6 | 20.6 | Titles, headings |
| `fontSize_7` | 24.3 | 24.3 | Large headings |
| `fontSize_8` | 30 | 30 | Extra large text |
| `fontSize_9` | 37.5 | 37.5 | Display text |

### Flutter Implementation

```dart
// In Dart/Flutter, use logical pixels (sp for scalable pixels)
const fontSize0 = 9.4;
const fontSize1 = 11.3;
const fontSize2 = 13.1;
const fontSize3 = 15.0;
const fontSize4 = 16.9;
const fontSize5 = 18.8;
const fontSize6 = 20.6;
const fontSize7 = 24.3;
const fontSize8 = 30.0;
const fontSize9 = 37.5;
```

---

## 🏗️ Font Weights

### Weight Scale

| Weight | Numeric | CSS | Usage |
|--------|---------|-----|-------|
| Regular | 400 | `FontWeight.w400` | Body text, standard |
| Medium | 500 | `FontWeight.w500` | Buttons, emphasis |
| Semibold | 600 | `FontWeight.w600` | Headings, strong text |
| Bold | 700 | `FontWeight.w700` | Titles, important text |

### Usage Guidelines

**400 (Regular):**
- Body text
- Descriptions
- Secondary information
- Most paragraph text

**500 (Medium):**
- Buttons
- Navigation items
- Emphasized text
- Labels

**600 (Semibold):**
- Headings (small)
- Titles
- Strong emphasis
- Active states

**700 (Bold):**
- Main titles
- Display text
- Most important text
- Brand names

---

## 📐 Line Heights

### Line Height Scale

| Name | Ratio | Usage |
|------|-------|-------|
| `lineHeight_tight` | 1.15 | Headings, tight spacing |
| `lineHeight_snug` | 1.3 | Standard body text |
| `lineHeight_relaxed` | 1.5 | Relaxed body text, readability |

### Calculated Values

| Font Size | Tight (1.15) | Snug (1.3) | Relaxed (1.5) |
|-----------|-------------|------------|---------------|
| 9.4 | 10.81 | 12.22 | 14.1 |
| 11.3 | 12.995 | 14.69 | 16.95 |
| 13.1 | 15.065 | 17.03 | 19.65 |
| 15 | 17.25 | 19.5 | 22.5 |
| 16.9 | 19.435 | 21.97 | 25.35 |
| 18.8 | 21.62 | 24.44 | 28.2 |
| 20.6 | 23.69 | 26.78 | 30.9 |
| 24.3 | 27.945 | 31.59 | 36.45 |
| 30 | 34.5 | 39 | 45 |
| 37.5 | 43.125 | 48.75 | 56.25 |

### Flutter Implementation

```dart
const lineHeightTight = 1.15;
const lineHeightSnug = 1.3;
const lineHeightRelaxed = 1.5;

// Usage in TextStyle
TextStyle(
  fontSize: 15,
  height: lineHeightSnug, // 1.3
  // ...
)
```

---

## 🔤 Letter Spacing (Tracking)

### Zero Tracking Principle

**Tracking is zero everywhere.** This is a deliberate design choice that distinguishes Kyron/Bluesky from Material Design.

- **No negative letter-spacing** on headings
- **No positive letter-spacing** on body text
- **Consistent zero tracking** across all text

### Comparison with Material

| Element | Material Design | Kyron/Bluesky |
|---------|----------------|--------------|
| Headings | -0.6 to -1.5 | 0 |
| Body | 0.25 to 0.5 | 0 |
| Buttons | 1.25 | 0 |
| Captions | 0.4 | 0 |

### Why Zero Tracking?

1. **Cleaner Appearance**: Text looks more natural and readable
2. **Consistency**: No need to adjust tracking for different text sizes
3. **Performance**: Fewer calculations for text rendering
4. **Brand Identity**: Distinctive "Bluesky look"

---

## 📱 Text Styles

### Standard Text Styles

Based on the existing `app_theme.dart` implementation:

```dart
TextTheme _baseTextTheme(Color primary, Color secondary) => TextTheme(
  // Display
  displayLarge: TextStyle(
    fontSize: 28,           // Custom (not in ALF scale)
    fontWeight: FontWeight.w600,
    color: primary,
    letterSpacing: 0,      // Zero tracking
    height: 1.15,          // Tight
  ),
  
  // Headings
  headlineMedium: TextStyle(
    fontSize: 22,           // Custom
    fontWeight: FontWeight.w500,
    color: primary,
    letterSpacing: 0,
    height: 1.3,           // Snug
  ),
  
  // Titles
  titleLarge: TextStyle(
    fontSize: 20,           // Close to fontSize_6 (20.6)
    fontWeight: FontWeight.w600,
    color: primary,
    letterSpacing: 0,
    height: 1.3,           // Snug
  ),
  titleMedium: TextStyle(
    fontSize: 18,           // Close to fontSize_5 (18.8)
    fontWeight: FontWeight.w600,
    color: primary,
    letterSpacing: 0,
    height: 1.3,
  ),
  titleSmall: TextStyle(
    fontSize: 16,           // Close to fontSize_4 (16.9)
    fontWeight: FontWeight.w600,
    color: primary,
    letterSpacing: 0,
    height: 1.3,
  ),
  
  // Body
  bodyLarge: TextStyle(
    fontSize: 16,           // fontSize_4 (16.9)
    fontWeight: FontWeight.w400,
    color: primary,
    letterSpacing: 0,
    height: 1.5,           // Relaxed
  ),
  bodyMedium: TextStyle(
    fontSize: 14,           // Close to fontSize_2 (13.1)
    fontWeight: FontWeight.w400,
    color: secondary,
    letterSpacing: 0,
    height: 1.5,
  ),
  
  // Labels
  labelLarge: TextStyle(
    fontSize: 16,           // fontSize_4 (16.9)
    fontWeight: FontWeight.w500,
    color: primary,
    letterSpacing: 0,
    height: 1.3,
  ),
  labelMedium: TextStyle(
    fontSize: 14,           // Close to fontSize_2 (13.1)
    fontWeight: FontWeight.w500,
    color: primary,
    letterSpacing: 0,
    height: 1.3,
  ),
  labelSmall: TextStyle(
    fontSize: 12,           // Close to fontSize_1 (11.3)
    fontWeight: FontWeight.w500,
    color: secondary,
    letterSpacing: 0,
    height: 1.3,
  ),
);
```

### Recommended Text Styles (ALF-Aligned)

```dart
// Updated to use exact ALF values
TextTheme _alfTextTheme(Color primary, Color secondary) => TextTheme(
  displayLarge: TextStyle(
    fontSize: 37.5,         // fontSize_9
    fontWeight: FontWeight.w700,
    color: primary,
    letterSpacing: 0,
    height: 1.15,
  ),
  displayMedium: TextStyle(
    fontSize: 30,           // fontSize_8
    fontWeight: FontWeight.w700,
    color: primary,
    letterSpacing: 0,
    height: 1.15,
  ),
  displaySmall: TextStyle(
    fontSize: 24.3,         // fontSize_7
    fontWeight: FontWeight.w600,
    color: primary,
    letterSpacing: 0,
    height: 1.15,
  ),
  
  headlineLarge: TextStyle(
    fontSize: 20.6,         // fontSize_6
    fontWeight: FontWeight.w600,
    color: primary,
    letterSpacing: 0,
    height: 1.3,
  ),
  headlineMedium: TextStyle(
    fontSize: 18.8,         // fontSize_5
    fontWeight: FontWeight.w600,
    color: primary,
    letterSpacing: 0,
    height: 1.3,
  ),
  headlineSmall: TextStyle(
    fontSize: 16.9,         // fontSize_4
    fontWeight: FontWeight.w600,
    color: primary,
    letterSpacing: 0,
    height: 1.3,
  ),
  
  titleLarge: TextStyle(
    fontSize: 15,           // fontSize_3 (base)
    fontWeight: FontWeight.w600,
    color: primary,
    letterSpacing: 0,
    height: 1.3,
  ),
  titleMedium: TextStyle(
    fontSize: 13.1,         // fontSize_2
    fontWeight: FontWeight.w600,
    color: primary,
    letterSpacing: 0,
    height: 1.3,
  ),
  titleSmall: TextStyle(
    fontSize: 11.3,         // fontSize_1
    fontWeight: FontWeight.w600,
    color: primary,
    letterSpacing: 0,
    height: 1.3,
  ),
  
  bodyLarge: TextStyle(
    fontSize: 16.9,         // fontSize_4
    fontWeight: FontWeight.w400,
    color: primary,
    letterSpacing: 0,
    height: 1.5,
  ),
  bodyMedium: TextStyle(
    fontSize: 15,           // fontSize_3 (base)
    fontWeight: FontWeight.w400,
    color: primary,
    letterSpacing: 0,
    height: 1.5,
  ),
  bodySmall: TextStyle(
    fontSize: 13.1,         // fontSize_2
    fontWeight: FontWeight.w400,
    color: secondary,
    letterSpacing: 0,
    height: 1.5,
  ),
  
  labelLarge: TextStyle(
    fontSize: 16.9,         // fontSize_4
    fontWeight: FontWeight.w500,
    color: primary,
    letterSpacing: 0,
    height: 1.3,
  ),
  labelMedium: TextStyle(
    fontSize: 15,           // fontSize_3
    fontWeight: FontWeight.w500,
    color: primary,
    letterSpacing: 0,
    height: 1.3,
  ),
  labelSmall: TextStyle(
    fontSize: 13.1,         // fontSize_2
    fontWeight: FontWeight.w500,
    color: secondary,
    letterSpacing: 0,
    height: 1.3,
  ),
);
```

---

## 🏷️ Specific Text Uses

### Button Text

From Bluesky's `Button.tsx`:

| Size | Text Size | Weight |
|------|-----------|--------|
| Large | 15 (fontSize_3) | Medium (500) |
| Small | 13.1 (fontSize_2) | Medium (500) |
| Tiny | 11.3 (fontSize_1) | Semibold (600) |

```dart
// Button text styles
TextStyle(
  fontSize: 15,           // Large button
  fontWeight: FontWeight.w500,
  letterSpacing: 0,
  height: 1.3,
)

TextStyle(
  fontSize: 13.1,         // Small button
  fontWeight: FontWeight.w500,
  letterSpacing: 0,
  height: 1.3,
)

TextStyle(
  fontSize: 11.3,         // Tiny button
  fontWeight: FontWeight.w600,
  letterSpacing: 0,
  height: 1.3,
)
```

### Input Text

```dart
TextStyle(
  fontSize: 16.9,         // fontSize_4
  fontWeight: FontWeight.w400,
  letterSpacing: 0,
  height: 1.5,
)
```

### Timestamp Text

```dart
TextStyle(
  fontSize: 13.1,         // fontSize_2
  fontWeight: FontWeight.w400,
  color: textTertiary,    // contrast_400
  letterSpacing: 0,
  height: 1.3,
)
```

---

## 🌍 Font Family

### Primary Font: Inter

**Inter** is the primary font family for Kyron, as used in the current implementation.

**Why Inter?**
- Excellent readability
- Large character set
- Multiple weights (1-9)
- Variable font support
- Open source (SIL Open Font License)

### Flutter Implementation

```dart
const _fontFamily = 'Inter';

// Apply to all text themes
TextTheme _baseTextTheme(...) => TextTheme(...).apply(
  fontFamily: _fontFamily,
);
```

### Font Weights Available

| Weight | Inter | Usage |
|--------|-------|-------|
| 100 | Thin | Rarely used |
| 200 | Extra Light | Rarely used |
| 300 | Light | Secondary text |
| 400 | Regular | Body text |
| 500 | Medium | Emphasis |
| 600 | Semi Bold | Headings |
| 700 | Bold | Titles |
| 800 | Extra Bold | Display |
| 900 | Black | Rarely used |

---

## ♿ Accessibility

### Text Size Requirements

**Minimum Text Size:** 12sp (scalable pixels)
- Smallest text in Kyron: 9.4sp (captions, labels)
- **Note**: 9.4sp is below minimum, consider increasing for accessibility

### Dynamic Type Support

Flutter's `TextStyle` automatically supports dynamic type:

```dart
Text(
  'Hello',
  style: TextStyle(
    fontSize: 16.9,  // Will scale with user's text size preference
  ),
)
```

### Text Scaling

**Test with different text scales:**
- Small: 0.8x
- Normal: 1.0x
- Large: 1.2x
- Largest: 1.5x

Ensure all text remains readable and layouts don't break.

---

## 📊 Token Export

For programmatic access:

```json
{
  "typography": {
    "fontFamily": "Inter",
    "fontSizes": {
      "0": 9.4,
      "1": 11.3,
      "2": 13.1,
      "3": 15.0,
      "4": 16.9,
      "5": 18.8,
      "6": 20.6,
      "7": 24.3,
      "8": 30.0,
      "9": 37.5
    },
    "fontWeights": {
      "regular": 400,
      "medium": 500,
      "semibold": 600,
      "bold": 700
    },
    "lineHeights": {
      "tight": 1.15,
      "snug": 1.3,
      "relaxed": 1.5
    },
    "tracking": 0,
    "textStyles": {
      "displayLarge": {
        "fontSize": 37.5,
        "fontWeight": 700,
        "lineHeight": 1.15,
        "tracking": 0
      },
      "displayMedium": {
        "fontSize": 30.0,
        "fontWeight": 700,
        "lineHeight": 1.15,
        "tracking": 0
      },
      "headlineLarge": {
        "fontSize": 20.6,
        "fontWeight": 600,
        "lineHeight": 1.3,
        "tracking": 0
      },
      "headlineMedium": {
        "fontSize": 18.8,
        "fontWeight": 600,
        "lineHeight": 1.3,
        "tracking": 0
      },
      "bodyLarge": {
        "fontSize": 16.9,
        "fontWeight": 400,
        "lineHeight": 1.5,
        "tracking": 0
      },
      "bodyMedium": {
        "fontSize": 15.0,
        "fontWeight": 400,
        "lineHeight": 1.5,
        "tracking": 0
      },
      "labelLarge": {
        "fontSize": 16.9,
        "fontWeight": 500,
        "lineHeight": 1.3,
        "tracking": 0
      },
      "buttonLarge": {
        "fontSize": 15.0,
        "fontWeight": 500,
        "lineHeight": 1.3,
        "tracking": 0
      },
      "buttonSmall": {
        "fontSize": 13.1,
        "fontWeight": 500,
        "lineHeight": 1.3,
        "tracking": 0
      },
      "buttonTiny": {
        "fontSize": 11.3,
        "fontWeight": 600,
        "lineHeight": 1.3,
        "tracking": 0
      }
    }
  }
}
```

---

## 🔗 References

- [Bluesky ALF Tokens](https://github.com/bluesky-social/social-app/blob/main/src/alf/tokens.ts)
- [Inter Font](https://rsms.me/inter/)
- [Flutter Typography](https://api.flutter.dev/flutter/material/TextTheme-class.html)
- [Material Design Typography](https://m3.material.io/styles/typography/overview)

---

*"Typography is what language looks like."*

**Typography System Documentation** — Version 1.0 — Kyron Design System
