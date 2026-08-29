# Border Radius System

## 🔳 Border Radius Philosophy

Kyron's border radius system is **simple and intentional**. We use a **limited set of radius values** to create a consistent visual language, with **fully rounded pills** for buttons and **sharp corners** for most other elements.

### Core Principles

1. **Flat Interface**: No elevated cards, no shadows for separation
2. **Pill Buttons**: All buttons are fully rounded pills
3. **Consistent Corners**: Same radius values used throughout
4. **Hairline Separation**: 1px borders, not rounded corners, for separation
5. **Special Cases**: Bottom sheets, content cards, inputs, images

---

## 📐 Radius Scale

From Bluesky's ALF `src/tokens.ts`:

```
radius: 2 · 4 · 8 · 12 · 16 · 20 · 999
```

| Name | Value (px) | Usage |
|------|------------|-------|
| `radius_2` | 2 | Subtle rounding, micro elements |
| `radius_4` | 4 | Small rounding, compact elements |
| `radius_8` | 8 | Medium rounding (`radius.sm`) |
| `radius_12` | 12 | Standard rounding (`radius.md`) |
| `radius_16` | 16 | Large rounding |
| `radius_20` | 20 | Bottom sheet top corners |
| `radius_full` | 999 | Fully rounded (pill shape) |

### Flutter Implementation

```dart
// Radius constants
const radius2 = 2.0;
const radius4 = 4.0;
const radius8 = 8.0;
const radius12 = 12.0;
const radius16 = 16.0;
const radius20 = 20.0;
const radiusFull = 999.0; // Effectively infinite

// BorderRadius helpers
const borderRadius2 = BorderRadius.all(Radius.circular(radius2));
const borderRadius4 = BorderRadius.all(Radius.circular(radius4));
const borderRadius8 = BorderRadius.all(Radius.circular(radius8));
const borderRadius12 = BorderRadius.all(Radius.circular(radius12));
const borderRadius16 = BorderRadius.all(Radius.circular(radius16));
const borderRadius20 = BorderRadius.all(Radius.circular(radius20));
const borderRadiusFull = BorderRadius.all(Radius.circular(radiusFull));

// Named radii for clarity
const radiusSm = radius8;    // Small radius
const radiusMd = radius12;   // Medium radius
const radiusLg = radius16;   // Large radius
```

---

## 🎯 Radius Usage

### Buttons

**All buttons are fully rounded pills.**

From Bluesky's `Button.tsx`:
```
// Buttons use radius.full (999)
```

**Flutter Implementation:**

```dart
// All button types use pill shape
ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: borderRadiusFull, // 999 = pill
  ),
)

OutlinedButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: borderRadiusFull,
  ),
)

TextButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: borderRadiusFull,
  ),
)

// Custom pill button
Container(
  decoration: BoxDecoration(
    borderRadius: borderRadiusFull,
    color: Colors.blue,
  ),
  child: ...
)
```

### Bottom Sheets

From Bluesky's `Dialog/index.tsx`:
```
cornerRadius={20}  // radius_20 for top corners only
```

**Flutter Implementation:**

```dart
showModalBottomSheet(
  context: context,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(radius20), // 20
    ),
  ),
  child: ...
)
```

### Content Cards

**Content cards, inputs, and images use `radius.md` (12) or `radius.sm` (8).**

```dart
// Card with medium radius
Card(
  shape: RoundedRectangleBorder(
    borderRadius: borderRadius12, // 12
  ),
  child: ...
)

// Input field with medium radius
InputDecoration(
  border: OutlineInputBorder(
    borderRadius: borderRadius12, // 12
  ),
)

// Image with medium radius
ClipRRect(
  borderRadius: borderRadius12, // 12
  child: Image.network(...),
)
```

### Other Elements

```dart
// Small elements (badges, chips)
Container(
  decoration: BoxDecoration(
    borderRadius: borderRadius8, // 8 (radius.sm)
    color: Colors.grey,
  ),
  child: ...
)

// Avatars (circular)
CircleAvatar(
  radius: 20, // Not a border radius, but avatar size
)

// Custom rounded container
Container(
  decoration: BoxDecoration(
    borderRadius: borderRadius4, // 4
    color: Colors.white,
  ),
  child: ...
)
```

---

## 📦 Common Radius Patterns

### 1. Pill Buttons

```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    shape: StadiumBorder(), // Alternative to borderRadiusFull
    // or
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(999),
    ),
  ),
  child: Text('Pill Button'),
)
```

### 2. Cards with Rounded Corners

```dart
Card(
  elevation: 0, // Flat interface
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  child: Padding(
    padding: EdgeInsets.all(16),
    child: ...
  ),
)
```

### 3. Input Fields

```dart
TextField(
  decoration: InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: Colors.grey[100],
  ),
)
```

### 4. Images with Rounded Corners

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: Image.network(
    'https://example.com/image.jpg',
    fit: BoxFit.cover,
  ),
)
```

### 5. Bottom Sheets

```dart
showModalBottomSheet(
  context: context,
  backgroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      top: Radius.circular(20),
    ),
  ),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      // Grab handle
      Container(
        width: 40,
        height: 4,
        margin: EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      // Content
      ...
    ],
  ),
)
```

---

## 🌐 Responsive Radius

### Density-Based Radius

```dart
// Adjust radius based on density preference
BorderRadius get densityBorderRadius(bool compact) {
  return compact
    ? BorderRadius.circular(radius8)   // Compact: 8
    : BorderRadius.circular(radius12); // Comfortable: 12
}
```

### Platform-Specific Radius

```dart
// Different radius for different platforms
BorderRadius get platformBorderRadius() {
  if (Platform.isIOS) {
    return BorderRadius.circular(radius12); // iOS: 12
  } else if (Platform.isAndroid) {
    return BorderRadius.circular(radius8);  // Android: 8
  }
  return BorderRadius.circular(radius12); // Default: 12
}
```

---

## ♿ Accessibility Radius

### Focus Indicators

```dart
// Custom focus decoration with radius
Material(
  borderRadius: BorderRadius.circular(radius12),
  child: Focus(
    focusNode: myFocusNode,
    child: ...
  ),
)
```

### Touch Targets

```dart
// Ensure rounded elements have sufficient touch area
InkWell(
  borderRadius: BorderRadius.circular(radius12),
  customBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radius12),
  ),
  child: Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius12),
    ),
    child: ...
  ),
)
```

---

## 📊 Token Export

For programmatic access:

```json
{
  "radius": {
    "scale": [2, 4, 8, 12, 16, 20, 999],
    "values": {
      "2": 2,
      "4": 4,
      "8": 8,
      "12": 12,
      "16": 16,
      "20": 20,
      "full": 999
    },
    "named": {
      "sm": 8,
      "md": 12,
      "lg": 16,
      "xl": 20,
      "full": 999
    },
    "usage": {
      "button": 999,
      "bottomSheet": 20,
      "card": 12,
      "input": 12,
      "image": 12,
      "badge": 8,
      "subtle": 4,
      "micro": 2
    }
  }
}
```

---

## 🔗 References

- [Bluesky ALF Tokens](https://github.com/bluesky-social/social-app/blob/main/src/alf/tokens.ts)
- [Bluesky Button Component](https://github.com/bluesky-social/social-app/blob/main/src/components/Button.tsx)
- [Bluesky Dialog Component](https://github.com/bluesky-social/social-app/blob/main/src/components/Dialog/index.tsx)
- [Material Design Shape](https://m3.material.io/styles/shape/overview)

---

*"Round the corners, but keep the edges sharp where it matters."*

**Border Radius System Documentation** — Version 1.0 — Kyron Design System
