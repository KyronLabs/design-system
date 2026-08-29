# Frontend Design Philosophy

## 🎨 Design Principles

Kyron's frontend design is built on **Bluesky's ALF (Application Layout Framework)** foundation, adapted and extended for the unique needs of a user-owned social platform with AR capabilities.

### Core Philosophy

> "**The finger drives the screen, the network follows.**"

This principle guides all interaction design: user actions should feel **instant** and **direct**, with the network catching up in the background.

---

## 🏗️ Design Pillars

### 1. Flat & Hairline-Separated Interface

**No elevated cards. No shadows for separation.**

- **Separation comes from 1px hairline borders**, not depth or shadows
- **Hairlines run full-bleed**, edge to edge
- **Backgrounds are flat colors**, not gradients or textures
- **Content sits directly on the page**, not in floating cards

**Why?**
- Cleaner, more modern appearance
- Better performance (no shadow calculations)
- Consistent across all themes
- Easier to maintain and understand

### 2. Pill-Shaped Interactive Elements

**All buttons are fully rounded pills.**

- **Not 16px rounded rectangles**
- **Fully rounded** (`radius.full` = 999)
- **Consistent across all button sizes**
- **Includes all button variants** (primary, secondary, text)

**Why?**
- Distinctive visual identity
- Comfortable touch targets
- Flows naturally with flat interface
- Matches Bluesky's proven design

### 3. Bottom Sheets Over Dialogs

**Every confirmation, picker, form, and menu is a bottom sheet.**

- **No centered alert dialogs** on mobile
- **Grab handle** on top
- **20px top corner radius**
- **Full-width** on mobile
- **Slide up from bottom**

**Why?**
- More natural on mobile (thumb reachable)
- Consistent with modern mobile apps
- Better for forms and complex inputs
- Matches Bluesky's approach

### 4. Zero Tracking Typography

**No negative letter-spacing anywhere.**

- **Tracking is zero** on all text
- **No letter-spacing adjustments**
- **Fractional font sizes** preserved (15, 16.9, 18.8...)
- **Modular scale** (1.125 ratio from 15px base)

**Why?**
- Cleaner, more natural text
- Consistent with Bluesky's design
- Better readability
- Simpler implementation

### 5. Performance-First Animations

**Short durations, scale+opacity, no ripples.**

- **Durations**: 90ms (micro), 180ms (fast), 260ms (normal), 420ms (slow)
- **Press interaction**: Scale (0.97) + Opacity (0.85)
- **No ink ripples**: `splashFactory: NoSplash`
- **Platform-native transitions**: iOS slide, Android predictive-back

**Why?**
- Feels instant and responsive
- Matches user expectations
- Better performance
- Consistent with Bluesky

---

## 🎯 Interface Style Guide

### Do's ✅

1. **Use hairline borders** for separation (1px, `border_contrast_low`)
2. **Make all buttons pills** (fully rounded)
3. **Use bottom sheets** for all modals on mobile
4. **Preserve fractional font sizes** (don't round 16.9 to 17)
5. **Use zero tracking** on all text
6. **Fire haptics on touch-down**, not tap-up
7. **Use scale+opacity** for press states
8. **Disable ink ripples** (`splashFactory: NoSplash`)
9. **Use Iconsax** for all icons (bold/linear pairs)
10. **Paint SVGs in `currentColor`** and tint with `ColorFilter`

### Don'ts ❌

1. **Don't use elevated cards** or shadows for separation
2. **Don't use rounded rectangles** for buttons (use pills)
3. **Don't use centered dialogs** on mobile (use bottom sheets)
4. **Don't round font sizes** (16.9 ≠ 17)
5. **Don't use negative tracking** on headings
6. **Don't fire haptics on tap-up** (do it on touch-down)
7. **Don't use Material ink ripples**
8. **Don't use Material Icons** (use Iconsax)
9. **Don't hard-code SVG fills** (use `currentColor`)
10. **Don't create custom colors** outside the ramp system

---

## 📱 Platform-Specific Considerations

### iOS

- **Navigation**: Horizontal slide transitions
- **Haptics**: Full range of impact styles
- **Safe Areas**: Respect safe area insets
- **Scroll Behavior**: Native scroll physics

### Android

- **Haptics**: **All impacts clamped to Light** (critical!)
- **Navigation**: Predictive back gesture
- **Safe Areas**: Handle notch and status bar
- **Scroll Behavior**: Native scroll physics

### Web

- **Haptics**: **Disabled entirely** (no vibration on web)
- **Navigation**: Browser-native back/forward
- **Scroll Behavior**: Web scroll physics
- **Responsive**: Adapt to different screen sizes

---

## 🎨 Visual Language

### Color Usage

- **Primary text**: `contrast_1000`
- **Secondary text**: `contrast_700`
- **Tertiary text**: `contrast_400`
- **Timestamps**: `contrast_400`
- **Background**: `contrast_0`
- **Surface**: `contrast_50`
- **Accent**: `primary_500` (#006AFF)
- **Borders**: `contrast_100` (hairline), `contrast_200` (stronger)

### Typography

- **Base size**: 15px (fontSize_3)
- **Modular scale**: 1.125 ratio
- **Weights**: 400 (regular), 500 (medium), 600 (semibold), 700 (bold)
- **Line heights**: 1.15 (tight), 1.3 (snug), 1.5 (relaxed)
- **Tracking**: 0 everywhere

### Spacing

- **Scale**: 2, 4, 8, 12, 16, 20, 24, 28, 32, 40
- **Page margins**: 16
- **Section spacing**: 32
- **List item spacing**: 8
- **Button padding**: 12 vertical, 24 horizontal (large)

### Radius

- **Buttons**: Full pill (999)
- **Cards/Inputs/Images**: 12 (radius.md)
- **Bottom sheets**: 20 (top corners only)
- **Badges**: 8 (radius.sm)

---

## 🔄 Interaction Patterns

### Press Interaction

**State Changes:**
1. **Touch Down**: 
   - Scale to 0.97
   - Opacity to 0.85
   - Fire haptic (if enabled)
2. **Touch Up**:
   - Scale back to 1.0
   - Opacity back to 1.0
   - Trigger action

**Implementation:**
```dart
// Flutter Pressable equivalent
GestureDetector(
  onTapDown: (_) {
    // Scale and opacity change
    // Fire haptic
  },
  onTapUp: (_) {
    // Scale and opacity back
    // Trigger action
  },
  onTapCancel: () {
    // Scale and opacity back
  },
  child: Transform.scale(
    scale: _isPressed ? 0.97 : 1.0,
    child: Opacity(
      opacity: _isPressed ? 0.85 : 1.0,
      child: ...
    ),
  ),
)
```

### Optimistic Updates

**The Rule: Finger drives the screen, network follows.**

1. **User taps like button**
2. **UI updates immediately** (heart fills, count increments)
3. **Request sent to server** (in background)
4. **If success**: UI stays updated
5. **If failure**: UI rolls back to previous state

**Implementation:**
```dart
// Optimistic reaction toggle
void toggleReaction() {
  // 1. Update local state immediately
  setState(() {
    isLiked = !isLiked;
    likeCount += isLiked ? 1 : -1;
  });
  
  // 2. Send request to server
  try {
    await api.toggleReaction(postId);
    // Success: state already updated
  } catch (e) {
    // Failure: roll back
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
  }
}
```

### Coalesced Requests

**Multiple rapid taps = single request with final state.**

1. **User taps like 10 times quickly**
2. **Only the last state is sent** (not 10 separate requests)
3. **Debounced with 350ms delay**

**Implementation:**
```dart
// Coalesced reaction
Timer? _reactionTimer;
bool _reactionPending = false;

void toggleReaction() {
  // Update local state immediately
  setState(() {
    isLiked = !isLiked;
    likeCount += isLiked ? 1 : -1;
  });
  
  // Cancel previous timer
  _reactionTimer?.cancel();
  
  // Set new timer
  _reactionPending = true;
  _reactionTimer = Timer(Duration(milliseconds: 350), () async {
    try {
      await api.toggleReaction(postId);
    } catch (e) {
      // Roll back
      setState(() {
        isLiked = !isLiked;
        likeCount += isLiked ? 1 : -1;
      });
    }
    _reactionPending = false;
  });
}
```

---

## 🎯 Component Philosophy

### Buttons

**All buttons are pills with consistent geometry:**

| Size | Padding V | Padding H | Gap | Text Size | Weight |
|------|-----------|-----------|-----|-----------|--------|
| Large | 12 | 24 | 6 | 15 | Medium |
| Small | 8 | 14 | 5 | 13.1 | Medium |
| Tiny | 5 | 10 | 3 | 11.3 | Semibold |

**Variants:**
- **Solid Primary**: `primary_500` → `primary_600` (pressed) → `primary_200` (disabled)
- **Solid Secondary**: `contrast_50` → `contrast_100`
- **Solid Negative**: `negative_500` → `negative_600`
- **Outlined**: Border with accent color
- **Text**: Just text color, no background

### Inputs

**Flat, hairline-separated input fields:**

- **Border**: 1px `border_contrast_low` (hairline)
- **Radius**: 12 (radius.md)
- **Padding**: 16 vertical, 16 horizontal
- **Fill**: `contrast_50` (subtle background)
- **Focus**: Border changes to `primary_500`

### Cards

**Flat cards with hairline separation:**

- **No elevation** (flat interface)
- **No shadow**
- **Border**: 1px `border_contrast_low` (optional)
- **Radius**: 12 (radius.md)
- **Background**: `surface` color

### Bottom Sheets

**Full-width, bottom-aligned sheets:**

- **Radius**: 20 (top corners only)
- **Grab handle**: 4px × 40px bar at top
- **Background**: `surface` color
- **Elevation**: None (flat)
- **Animation**: Slide up (260ms)

### Thread Connectors

**Visual hierarchy for nested replies:**

- **Indent**: 30 (one avatar radius + gutter)
- **Thickness**: 2 (1px too thin, reads as hairline)
- **Corner**: 12 (half the indent, quarter-circle turns)
- **Max Indent**: 4 (prevents running off screen)

---

## 🌈 Theming

### Three Themes

| Theme | Background | Text | Usage |
|-------|------------|------|-------|
| Light | `#FFFFFF` | `#000000` | Default light mode |
| Dim | `#151D28` | `#F0F8FF` | Default dark mode |
| Dark | `#000000` | `#FFFFFF` | True black (OLED) |

**Theme Selection:**
- **System preference**: Follow device theme
- **User override**: User can choose any theme
- **Dim as default dark**: Most users prefer dim over pure black

### Theme Switching

```dart
// Theme switching implementation
void toggleTheme() {
  setState(() {
    currentTheme = currentTheme == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
  });
}

// Theme-aware colors
Color get backgroundColor => 
    Theme.of(context).brightness == Brightness.dark
        ? AppTheme.background
        : AppTheme.lightBackground;
```

---

## ♿ Accessibility

### Color Contrast

- **Minimum**: 4.5:1 for normal text
- **Large text**: 3:1 minimum
- **All color combinations tested**

### Touch Targets

- **Minimum**: 44×44 logical pixels
- **Buttons**: All meet minimum
- **Icons**: Padded to meet minimum

### Screen Readers

- **Semantics**: All interactive elements have semantics
- **Labels**: All icons have text labels
- **Announcements**: Important changes announced

### Reduced Motion

- **Respect system preference**: Check `MediaQuery.of(context).prefersReducedMotion`
- **Fallback**: Replace animations with instant changes

---

## 📈 Performance Guidelines

### Rendering

- **60fps**: All animations must run at 60fps
- **No jank**: No dropped frames during scrolling
- **Efficient widgets**: Use `const` widgets where possible
- **Avoid rebuilds**: Use `Provider`, `Riverpod`, or similar for state

### Image Loading

- **Lazy loading**: Load images as they scroll into view
- **Placeholders**: Show low-res preview or solid color
- **Caching**: Cache images for offline viewing
- **Optimization**: Serve appropriately sized images

### List Performance

- **Pagination**: Load data in chunks
- **Item builder**: Use `ListView.builder` for long lists
- **Keep-alive**: Cache list items that are likely to be reused
- **Diffing**: Use keys for efficient diffing

---

## 🔗 References

- [Bluesky ALF Design System](https://github.com/bluesky-social/social-app/tree/main/src/alf)
- [Material Design Guidelines](https://m3.material.io/)
- [Flutter Best Practices](https://docs.flutter.dev/perf/best-practices)
- [Accessibility Guidelines](https://www.w3.org/WAI/)

---

*"Good design is obvious. Great design is transparent."*

**Frontend Design Philosophy** — Version 1.0 — Kyron Design System
