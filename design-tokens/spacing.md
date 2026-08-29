# Spacing System

## 📏 Spacing Philosophy

Kyron's spacing system is **simple, consistent, and predictable**. It uses a **multiplicative scale** based on powers of 2, with a few strategic additions for specific use cases.

### Core Principles

1. **Base Unit**: 4px (but 2px is the smallest increment)
2. **Scale**: 2, 4, 8, 12, 16, 20, 24, 28, 32, 40
3. **Consistency**: Same spacing values used throughout the UI
4. **Predictability**: Spacing follows a clear pattern
5. **Efficiency**: Minimal set of values that cover all needs

---

## 📐 Spacing Scale

### Primary Scale

From Bluesky's ALF `src/tokens.ts`:

```
space: 2 · 4 · 8 · 12 · 16 · 20 · 24 · 28 · 32 · 40
```

| Name | Value (px) | Usage |
|------|------------|-------|
| `space_2` | 2 | Micro spacing, hairline adjustments |
| `space_4` | 4 | Tight spacing, icon padding |
| `space_8` | 8 | Small padding, compact elements |
| `space_12` | 12 | Standard padding, medium spacing |
| `space_16` | 16 | Default padding, comfortable spacing |
| `space_20` | 20 | Large padding, section spacing |
| `space_24` | 24 | Extra large padding, card margins |
| `space_28` | 28 | Special spacing (bottom sheet radius) |
| `space_32` | 32 | Section margins, large gaps |
| `space_40` | 40 | Page margins, very large gaps |

### Flutter Implementation

```dart
// Spacing constants
const space2 = 2.0;
const space4 = 4.0;
const space8 = 8.0;
const space12 = 12.0;
const space16 = 16.0;
const space20 = 20.0;
const space24 = 24.0;
const space28 = 28.0;
const space32 = 32.0;
const space40 = 40.0;

// EdgeInsets helpers
const edgeInset2 = EdgeInsets.all(space2);
const edgeInset4 = EdgeInsets.all(space4);
const edgeInset8 = EdgeInsets.all(space8);
const edgeInset12 = EdgeInsets.all(space12);
const edgeInset16 = EdgeInsets.all(space16);
const edgeInset20 = EdgeInsets.all(space20);
const edgeInset24 = EdgeInsets.all(space24);
const edgeInset32 = EdgeInsets.all(space32);

// Symmetric EdgeInsets
const edgeInsetHorizontal4 = EdgeInsets.symmetric(horizontal: space4);
const edgeInsetHorizontal8 = EdgeInsets.symmetric(horizontal: space8);
const edgeInsetHorizontal12 = EdgeInsets.symmetric(horizontal: space12);
const edgeInsetHorizontal16 = EdgeInsets.symmetric(horizontal: space16);
const edgeInsetHorizontal20 = EdgeInsets.symmetric(horizontal: space20);

const edgeInsetVertical4 = EdgeInsets.symmetric(vertical: space4);
const edgeInsetVertical8 = EdgeInsets.symmetric(vertical: space8);
const edgeInsetVertical12 = EdgeInsets.symmetric(vertical: space12);
const edgeInsetVertical16 = EdgeInsets.symmetric(vertical: space16);
const edgeInsetVertical20 = EdgeInsets.symmetric(vertical: space20);
```

---

## 🎯 Spacing Guidelines

### Component Spacing

#### Buttons

From Bluesky's `Button.tsx`:

| Size | Padding Vertical | Padding Horizontal | Gap | Min Height |
|------|------------------|---------------------|-----|------------|
| Large | 12 (`space_12`) | 24 (`space_24`) | 6 | 48px |
| Small | 8 (`space_8`) | 14 | 5 | 40px |
| Tiny | 5 | 10 | 3 | 32px |

**Flutter Implementation:**

```dart
// Large button
ElevatedButton.styleFrom(
  padding: EdgeInsets.symmetric(
    vertical: space12,  // 12
    horizontal: space24, // 24
  ),
  minimumSize: Size.fromHeight(48),
)

// Small button
ElevatedButton.styleFrom(
  padding: EdgeInsets.symmetric(
    vertical: space8,   // 8
    horizontal: 14,    // Custom (not in scale)
  ),
  minimumSize: Size.fromHeight(40),
)
```

#### Input Fields

```dart
InputDecorationTheme(
  contentPadding: EdgeInsets.symmetric(
    vertical: space16,  // 16
    horizontal: space16, // 16
  ),
)
```

#### Cards

```dart
Card(
  margin: edgeInset16,    // 16
  child: Padding(
    padding: edgeInset16,  // 16
    child: ...
  ),
)
```

### Layout Spacing

#### Page Margins

```dart
Padding(
  padding: edgeInset16,  // 16 on all sides
  child: ...
)
```

#### Section Spacing

```dart
Column(
  children: [
    Section1(),
    SizedBox(height: space32), // 32 between sections
    Section2(),
    SizedBox(height: space24), // 24 for closer sections
    Section3(),
  ],
)
```

#### List Items

```dart
ListView.separated(
  itemBuilder: (context, index) => ListItem(),
  separatorBuilder: (context, index) => SizedBox(height: space8), // 8
)
```

### Special Spacing

#### Bottom Sheet Radius

From Bluesky's `Dialog/index.tsx`:

```
cornerRadius={20}  // space_20
```

**Flutter Implementation:**

```dart
showModalBottomSheet(
  context: context,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(space20), // 20
    ),
  ),
  child: ...
)
```

#### Thread Indent

From `ThreadGeometry`:

```
indent: 30  // Not in spacing scale (special case)
```

This is **one avatar radius (20) + gutter (10)** = 30

---

## 📦 Common Spacing Patterns

### 1. Inline Elements

```dart
Row(
  children: [
    Icon(Icons.favorite),
    SizedBox(width: space8), // 8
    Text('Like'),
    SizedBox(width: space16), // 16
    Text('123'),
  ],
)
```

### 2. Stack Elements

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Title'),
    SizedBox(height: space4), // 4
    Text('Subtitle'),
    SizedBox(height: space8), // 8
    Text('Description'),
  ],
)
```

### 3. Grid Spacing

```dart
GridView.count(
  crossAxisCount: 2,
  crossAxisSpacing: space12, // 12
  mainAxisSpacing: space12, // 12
  childAspectRatio: 1,
)
```

### 4. Padding Combinations

```dart
// Card with padding
Container(
  padding: EdgeInsets.only(
    top: space16,
    bottom: space16,
    left: space20,
    right: space20,
  ),
  child: ...
)

// Button with icon
ElevatedButton.icon(
  icon: Icon(Icons.add),
  label: Text('Add'),
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(
      horizontal: space16,
      vertical: space12,
    ),
  ),
)
```

---

## 🌐 Responsive Spacing

### Breakpoint-Based Spacing

```dart
// Responsive padding
EdgeInsets get responsivePadding(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  
  if (width >= 1200) {
    return EdgeInsets.all(space40); // Desktop: 40
  } else if (width >= 768) {
    return EdgeInsets.all(space24); // Tablet: 24
  } else {
    return EdgeInsets.all(space16); // Mobile: 16
  }
}
```

### Density-Based Spacing

```dart
// Compact vs comfortable spacing
EdgeInsets get densityPadding(bool compact) {
  return compact
    ? EdgeInsets.all(space8)   // Compact: 8
    : EdgeInsets.all(space16); // Comfortable: 16
}
```

---

## ♿ Accessibility Spacing

### Touch Targets

**Minimum touch target size: 44×44 logical pixels**

```dart
// Ensure buttons are large enough
ElevatedButton(
  style: ElevatedButton.styleFrom(
    minimumSize: Size(44, 44), // Minimum touch target
  ),
  child: Text('Tap'),
)

// Add padding to small elements
InkWell(
  customBorder: CircleBorder(),
  child: Padding(
    padding: EdgeInsets.all(space12), // 12 + icon size >= 44
    child: Icon(Icons.favorite),
  ),
)
```

### Spacing for Readability

```dart
// Ensure sufficient spacing around text
Text(
  'Long text that needs to be readable',
  style: TextStyle(
    height: 1.5, // Relaxed line height
  ),
)

// Add margin around text blocks
Padding(
  padding: EdgeInsets.all(space16), // 16
  child: Text('...'),
)
```

---

## 📊 Token Export

For programmatic access:

```json
{
  "spacing": {
    "scale": [2, 4, 8, 12, 16, 20, 24, 28, 32, 40],
    "values": {
      "2": 2,
      "4": 4,
      "8": 8,
      "12": 12,
      "16": 16,
      "20": 20,
      "24": 24,
      "28": 28,
      "32": 32,
      "40": 40
    },
    "special": {
      "threadIndent": 30,
      "bottomSheetRadius": 20,
      "avatarRadius": 20,
      "buttonLargePaddingV": 12,
      "buttonLargePaddingH": 24,
      "inputPadding": 16
    },
    "patterns": {
      "pageMargin": 16,
      "sectionSpacing": 32,
      "cardPadding": 16,
      "listItemSpacing": 8,
      "inlineSpacing": 8,
      "stackSpacing": 4
    }
  }
}
```

---

## 🔗 References

- [Bluesky ALF Tokens](https://github.com/bluesky-social/social-app/blob/main/src/alf/tokens.ts)
- [Material Design Spacing](https://m3.material.io/styles/spacing/overview)
- [8px Grid System](https://spec.fm/specifics/8pt-grid)

---

*"Good spacing is invisible. Bad spacing is all you see."*

**Spacing System Documentation** — Version 1.0 — Kyron Design System
