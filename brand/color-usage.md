# Brand Color Usage

## 🎨 Color Philosophy

Kyron's color system is **intentionally minimal** and **highly functional**. We use color to communicate meaning, not just for decoration. Every color choice should serve a clear purpose.

### Core Principles

1. **Primary First**: The accent color (`#006AFF`) is the brand's visual anchor
2. **Consistency**: Same colors mean the same things everywhere
3. **Accessibility**: All color combinations meet WCAG 2.1 AA standards
4. **Restraint**: Use color sparingly for maximum impact
5. **Theme Awareness**: Colors work in light, dim, and dark themes

---

## 🌈 Color Meanings

### Primary Accent: `#006AFF` (Bluesky Blue)

**Meaning:**
- Trust and reliability
- Technology and innovation
- Primary actions and interactive elements
- Brand identity

**Usage:**
- Primary buttons
- Active states
- Links
- Accents and highlights
- Selected items

**Do:**
- Use for primary actions (submit, confirm, create)
- Use for interactive elements
- Use for selected states
- Use for brand identity

**Don't:**
- Overuse (diminishes impact)
- Use for errors or warnings
- Use for secondary information
- Use for backgrounds (except subtle tints)

### Success: `#4CD4B0` (Positive Green)

**Meaning:**
- Success
- Positive actions
- Confirmation
- Growth

**Usage:**
- Success messages
- Upvote indicators
- Positive feedback
- Completed states

**Do:**
- Use for success states
- Use for positive actions
- Use sparingly for emphasis

**Don't:**
- Use for errors or warnings
- Overuse (reserve for true success)

### Error: `#FF6582` (Error Pink)

**Meaning:**
- Errors
- Destructive actions
- Warnings
- Problems

**Usage:**
- Error messages
- Delete buttons
- Warning indicators
- Failed states

**Do:**
- Use for errors and problems
- Use for destructive actions
- Use to draw attention to issues

**Don't:**
- Use for primary actions
- Use for positive feedback
- Overuse (only for genuine errors)

### Neutral Colors

**Contrast Ramp:**
- `contrast_0`: Backgrounds
- `contrast_50`: Subtle surfaces
- `contrast_100`: Hairline borders
- `contrast_200-300`: Stronger borders
- `contrast_400`: Tertiary text, timestamps
- `contrast_700`: Secondary text
- `contrast_1000`: Primary text

**Meaning:**
- Hierarchy and structure
- Readability
- Separation

**Usage:**
- Text (various levels)
- Backgrounds
- Borders
- Separators

---

## 📱 Color Usage by Component

### Buttons

| Variant | Background | Text | Border | Usage |
|---------|------------|------|-------|-------|
| Primary | `primary_500` | White | None | Main actions |
| Secondary | `contrast_50` | `contrast_1000` | None | Secondary actions |
| Negative | `negative_500` | White | None | Destructive actions |
| Outlined | Transparent | `primary_500` | `primary_500` | Alternative primary |
| Text | Transparent | `primary_500` | None | Minimal actions |

**States:**
- **Normal**: Full opacity, standard colors
- **Pressed**: Scale 0.97, opacity 0.85, pressed colors
- **Disabled**: Disabled colors, no interaction
- **Loading**: Disabled colors, spinner

### Inputs

| State | Background | Border | Text | Placeholder |
|-------|------------|--------|------|-------------|
| Normal | `contrast_50` | `contrast_300` | `contrast_1000` | `contrast_700` |
| Focused | `contrast_50` | `primary_500` | `contrast_1000` | `contrast_700` |
| Disabled | `contrast_50` | `contrast_300` | `contrast_700` | `contrast_700` |
| Error | `contrast_50` | `negative_500` | `contrast_1000` | `contrast_700` |

### Cards

| Element | Color | Usage |
|---------|-------|-------|
| Background | `surface` | Card background |
| Border | `contrast_100` | Optional hairline border |
| Text | `contrast_1000` | Primary text |
| Secondary Text | `contrast_700` | Secondary text |

### Navigation

| Element | Color | Usage |
|---------|-------|-------|
| Active Tab | `primary_500` | Active tab icon/text |
| Inactive Tab | `contrast_700` | Inactive tab icon/text |
| Background | `surface` | Navigation bar background |
| Border | `contrast_100` | Top hairline border |

### Text

| Level | Color | Usage |
|-------|-------|-------|
| Primary | `contrast_1000` | Main text, headings |
| Secondary | `contrast_700` | Supporting text |
| Tertiary | `contrast_400` | Timestamps, metadata |
| Link | `primary_500` | Clickable text |
| Success | `positive_500` | Success messages |
| Error | `negative_500` | Error messages |

---

## 🎨 Color Combinations

### Safe Combinations

| Background | Text | Status |
|------------|------|--------|
| `contrast_0` (Light) | `contrast_1000` | ✅ 21:1 |
| `contrast_0` (Dark) | `contrast_1000` | ✅ 21:1 |
| `contrast_50` (Light) | `contrast_1000` | ✅ 17:1 |
| `contrast_50` (Dark) | `contrast_1000` | ✅ 17:1 |
| `primary_500` | White | ✅ 4.6:1 |
| `primary_500` | Black | ❌ 1.5:1 |
| `surface` (Light) | `contrast_1000` | ✅ 15:1 |
| `surface` (Dark) | `contrast_1000` | ✅ 15:1 |

### Common Patterns

#### Primary Button on Light Background
```
Background: contrast_0 (#FFFFFF)
Button: primary_500 (#006AFF)
Text: White (#FFFFFF)
Contrast: 4.6:1 ✅
```

#### Primary Button on Dark Background
```
Background: contrast_0 (#000000)
Button: primary_500 (#006AFF)
Text: White (#FFFFFF)
Contrast: 4.6:1 ✅
```

#### Text on Light Background
```
Background: contrast_0 (#FFFFFF)
Primary Text: contrast_1000 (#000000)
Contrast: 21:1 ✅

Secondary Text: contrast_700 (#5C5C5C)
Contrast: 7.5:1 ✅

Tertiary Text: contrast_400 (#B0B0B0)
Contrast: 4.5:1 ✅
```

#### Text on Dark Background
```
Background: contrast_0 (#000000)
Primary Text: contrast_1000 (#FFFFFF)
Contrast: 21:1 ✅

Secondary Text: contrast_700 (#B0B0B0)
Contrast: 7.5:1 ✅

Tertiary Text: contrast_400 (#5C5C5C)
Contrast: 4.5:1 ✅
```

---

## 🌓 Theme-Specific Usage

### Light Theme

**Background:** `#FFFFFF` (contrast_0)
**Surface:** `#F7F7F7` (contrast_50)
**Text Primary:** `#000000` (contrast_1000)
**Text Secondary:** `#5C5C5C` (contrast_700)
**Text Tertiary:** `#B0B0B0` (contrast_400)
**Accent:** `#006AFF` (primary_500)
**Border:** `#E8E8E8` (contrast_100)

**Usage:**
- Primary buttons: `primary_500` background, white text
- Secondary buttons: `contrast_50` background, `contrast_1000` text
- Borders: `contrast_100` (hairline), `contrast_200` (stronger)

### Dim Theme

**Background:** `#151D28` (contrast_0)
**Surface:** `#1E2A38` (contrast_50)
**Text Primary:** `#F0F8FF` (contrast_1000)
**Text Secondary:** `#A8B8C8` (contrast_700)
**Text Tertiary:** `#607080` (contrast_400)
**Accent:** `#006AFF` (primary_500)
**Border:** `#2A3848` (contrast_100)

**Usage:**
- Primary buttons: `primary_500` background, white text
- Secondary buttons: `contrast_50` background, `contrast_1000` text
- Borders: `contrast_100` (hairline), `contrast_200` (stronger)

### Dark Theme

**Background:** `#000000` (contrast_0)
**Surface:** `#0A0A0A` (contrast_50)
**Text Primary:** `#FFFFFF` (contrast_1000)
**Text Secondary:** `#B0B0B0` (contrast_700)
**Text Tertiary:** `#5C5C5C` (contrast_400)
**Accent:** `#006AFF` (primary_500)
**Border:** `#1A1A1A` (contrast_100)

**Usage:**
- Same as other themes (colors are inverted)
- Primary buttons: `primary_500` background, white text
- Secondary buttons: `contrast_50` background, `contrast_1000` text

---

## 🎯 Color Hierarchy

### Primary Colors (60-70% of usage)

1. **Background**: `contrast_0` - Page and surface backgrounds
2. **Text Primary**: `contrast_1000` - Main text content
3. **Accent**: `primary_500` - Primary actions and brand identity

### Secondary Colors (20-30% of usage)

1. **Surface**: `contrast_50` - Elevated surfaces
2. **Text Secondary**: `contrast_700` - Supporting text
3. **Borders**: `contrast_100-300` - Separation and structure

### Tertiary Colors (<10% of usage)

1. **Text Tertiary**: `contrast_400` - Metadata and timestamps
2. **Success**: `positive_500` - Success states
3. **Error**: `negative_500-600` - Errors and warnings

---

## 📊 Color Usage Guidelines

### Color Distribution

**Recommended color distribution in UI:**

| Color Category | Percentage | Usage |
|---------------|------------|-------|
| Backgrounds | 40-50% | Page, surface backgrounds |
| Text Primary | 20-30% | Main text content |
| Accent | 5-10% | Primary actions, brand |
| Text Secondary | 10-15% | Supporting text |
| Borders | 5-10% | Separation, structure |
| Text Tertiary | 2-5% | Metadata, timestamps |
| Success/Error | <1% | Feedback states |

### Color Emphasis

**High Emphasis:**
- Primary text (`contrast_1000`)
- Primary buttons (`primary_500`)
- Active states

**Medium Emphasis:**
- Secondary text (`contrast_700`)
- Secondary buttons (`contrast_50`)
- Borders (`contrast_200-300`)

**Low Emphasis:**
- Tertiary text (`contrast_400`)
- Disabled states
- Placeholders

---

## 🧪 Color Testing

### Accessibility Testing

**Tools:**
- [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
- [Adobe Color Contrast Analyzer](https://color.adobe.com/create/color-contrast-analyzer)
- [Chrome DevTools Accessibility Panel](https://developer.chrome.com/docs/devtools/accessibility/)

**Tests:**
1. **Contrast Ratio**: All text must have minimum 4.5:1 contrast
2. **Color Blindness**: Test with different color blindness simulations
3. **Theme Testing**: Verify colors in all themes (light, dim, dark)
4. **Consistency**: Verify same colors mean the same things everywhere

### Color Blindness Simulation

| Type | Simulation | Check |
|------|------------|-------|
| Deuteranopia | Red-green | Verify success/error are distinguishable |
| Protanopia | Red-green | Verify success/error are distinguishable |
| Tritanopia | Blue-yellow | Verify primary accent is visible |
| Achromatopsia | Grayscale | Verify hierarchy through brightness |

---

## 📦 Color Palette Export

For design tools and development:

```json
{
  "brandColors": {
    "primary": {
      "value": "#006AFF",
      "name": "Bluesky Blue",
      "usage": "Primary actions, brand identity, links",
      "contrast": {
        "white": 4.6,
        "black": 1.5
      }
    },
    "success": {
      "value": "#4CD4B0",
      "name": "Success Aqua",
      "usage": "Success states, positive feedback",
      "contrast": {
        "white": 1.6,
        "black": 7.5
      }
    },
    "error": {
      "value": "#FF6582",
      "name": "Error Pink",
      "usage": "Errors, destructive actions, warnings",
      "contrast": {
        "white": 3.5,
        "black": 5.5
      }
    },
    "text": {
      "primary": {
        "light": "#000000",
        "dark": "#FFFFFF",
        "dim": "#F0F8FF"
      },
      "secondary": {
        "light": "#5C5C5C",
        "dark": "#B0B0B0",
        "dim": "#A8B8C8"
      },
      "tertiary": {
        "light": "#B0B0B0",
        "dark": "#5C5C5C",
        "dim": "#607080"
      }
    },
    "background": {
      "light": "#FFFFFF",
      "dark": "#000000",
      "dim": "#151D28"
    },
    "surface": {
      "light": "#F7F7F7",
      "dark": "#0A0A0A",
      "dim": "#1E2A38"
    }
  },
  "colorMeanings": {
    "#006AFF": "Primary actions, brand, links, selected states",
    "#4CD4B0": "Success, positive feedback, completed states",
    "#FF6582": "Errors, destructive actions, warnings",
    "#FFFFFF/#000000": "Primary text, high contrast",
    "#5C5C5C/#B0B0B0": "Secondary text, supporting information",
    "#B0B0B0/#5C5C5C": "Tertiary text, metadata, timestamps"
  }
}
```

---

## 🔗 References

- [WCAG 2.1 Color Contrast Guidelines](https://www.w3.org/WAI/WCAG21/quickref/#contrast)
- [WebAIM Color Contrast Checker](https://webaim.org/resources/contrastchecker/)
- [Adobe Color](https://color.adobe.com/)
- [Material Design Color](https://m3.material.io/styles/color/overview)

---

*"Color should communicate, not decorate."*

**Brand Color Usage Documentation** — Version 1.0 — Kyron Design System
