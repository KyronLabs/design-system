# Button System

## 🎯 Button Philosophy

Kyron's button system follows **Bluesky's pill-shaped button design** with consistent geometry, clear hierarchy, and instant feedback.

### Core Principles

1. **All buttons are pills**: Fully rounded (`radius.full` = 999)
2. **Consistent geometry**: Fixed padding and sizing per size variant
3. **Instant feedback**: Press state changes with scale + opacity
4. **Clear hierarchy**: Multiple variants for different purposes
5. **Platform-aware**: Different haptics per platform

---

## 📐 Button Geometry

From Bluesky's `Button.tsx`:

| Size | Padding V | Padding H | Gap | Text Size | Text Weight | Min Height |
|------|-----------|-----------|-----|-----------|-------------|------------|
| Large | 12 | 24 | 6 | 15 | Medium (500) | 48px |
| Small | 8 | 14 | 5 | 13.1 | Medium (500) | 40px |
| Tiny | 5 | 10 | 3 | 11.3 | Semibold (600) | 32px |

### Flutter Implementation

```dart
// Button size configurations
class ButtonSize {
  final double paddingVertical;
  final double paddingHorizontal;
  final double gap;
  final double fontSize;
  final FontWeight fontWeight;
  final double minHeight;
  
  const ButtonSize({
    required this.paddingVertical,
    required this.paddingHorizontal,
    required this.gap,
    required this.fontSize,
    required this.fontWeight,
    required this.minHeight,
  });
  
  static const large = ButtonSize(
    paddingVertical: 12,
    paddingHorizontal: 24,
    gap: 6,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    minHeight: 48,
  );
  
  static const small = ButtonSize(
    paddingVertical: 8,
    paddingHorizontal: 14,
    gap: 5,
    fontSize: 13.1,
    fontWeight: FontWeight.w500,
    minHeight: 40,
  );
  
  static const tiny = ButtonSize(
    paddingVertical: 5,
    paddingHorizontal: 10,
    gap: 3,
    fontSize: 11.3,
    fontWeight: FontWeight.w600,
    minHeight: 32,
  );
}
```

---

## 🎨 Button Variants

### Color Variants

| Variant | Background | Text | Pressed | Disabled |
|---------|------------|------|---------|----------|
| Solid Primary | `primary_500` | White | `primary_600` | `primary_200` |
| Solid Secondary | `contrast_50` | `contrast_1000` | `contrast_100` | `contrast_200` |
| Solid Negative | `negative_500` | White | `negative_600` | `negative_200` |
| Outlined | Transparent | `primary_500` | `primary_600` bg | `primary_200` border |
| Text | Transparent | `primary_500` | `primary_600` | `primary_200` |

### Flutter Implementation

```dart
// Button variants
enum ButtonVariant {
  solidPrimary,
  solidSecondary,
  solidNegative,
  outlined,
  text,
}

// Button colors
Map<ButtonVariant, ButtonColors> buttonColors = {
  ButtonVariant.solidPrimary: ButtonColors(
    background: AppTheme.accent, // primary_500
    foreground: Colors.white,
    pressedBackground: Color(0xFF005BCC), // primary_600
    disabledBackground: Color(0xFF99C2FF), // primary_200
    disabledForeground: Colors.white.withOpacity(0.5),
  ),
  ButtonVariant.solidSecondary: ButtonColors(
    background: AppTheme.darkPillBg, // contrast_50
    foreground: AppTheme.textPrimary, // contrast_1000
    pressedBackground: Color(0xFF1A1A1D), // contrast_100
    disabledBackground: Color(0xFF262626), // contrast_200
    disabledForeground: AppTheme.textSecondary.withOpacity(0.5),
  ),
  ButtonVariant.solidNegative: ButtonColors(
    background: AppTheme.errorPink, // negative_600
    foreground: Colors.white,
    pressedBackground: Color(0xFFCC3D3D), // negative_700
    disabledBackground: Color(0xFF992E2E), // negative_800
    disabledForeground: Colors.white.withOpacity(0.5),
  ),
  // ... outlined and text variants
};
```

---

## 🔧 Button Implementation

### Base Button Widget

```dart
class KyronButton extends StatefulWidget {
  final String text;
  final Widget? icon;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final ButtonVariant variant;
  final bool isLoading;
  final bool isDisabled;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  
  const KyronButton({
    required this.text,
    this.icon,
    this.onPressed,
    this.size = ButtonSize.large,
    this.variant = ButtonVariant.solidPrimary,
    this.isLoading = false,
    this.isDisabled = false,
    this.padding,
    this.width,
    this.height,
  });
  
  @override
  _KyronButtonState createState() => _KyronButtonState();
}

class _KyronButtonState extends State<KyronButton> {
  bool _isPressed = false;
  
  ButtonColors get _colors => buttonColors[widget.variant]!;
  
  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null && !widget.isDisabled && !widget.isLoading;
    final effectivePadding = widget.padding ?? EdgeInsets.symmetric(
      vertical: widget.size.paddingVertical,
      horizontal: widget.size.paddingHorizontal,
    );
    
    return Semantics(
      button: true,
      enabled: isEnabled,
      child: GestureDetector(
        onTapDown: (_) {
          if (isEnabled) {
            setState(() => _isPressed = true);
            Haptics.light(); // Fire haptic on touch down
          }
        },
        onTapUp: (_) {
          if (isEnabled) {
            setState(() => _isPressed = false);
            widget.onPressed?.call();
          }
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: motionMicro,
          transform: Matrix4.identity()..scale(_isPressed ? 0.97 : 1.0),
          transformAlignment: Alignment.center,
          child: Opacity(
            opacity: _isPressed ? 0.85 : 1.0,
            child: Container(
              width: widget.width,
              height: widget.height ?? widget.size.minHeight,
              padding: effectivePadding,
              decoration: BoxDecoration(
                color: _getBackgroundColor(isEnabled),
                borderRadius: BorderRadius.circular(999), // Pill shape
                border: _getBorder(isEnabled),
              ),
              child: _buildContent(isEnabled),
            ),
          ),
        ),
      ),
    );
  }
  
  Color _getBackgroundColor(bool isEnabled) {
    if (!isEnabled) return _colors.disabledBackground;
    if (_isPressed) return _colors.pressedBackground;
    return _colors.background;
  }
  
  Border? _getBorder(bool isEnabled) {
    if (widget.variant == ButtonVariant.outlined) {
      return Border.all(
        color: isEnabled 
            ? _colors.foreground 
            : _colors.disabledForeground,
        width: 1.0,
      );
    }
    return null;
  }
  
  Widget _buildContent(bool isEnabled) {
    final textColor = isEnabled 
        ? (_isPressed ? _colors.foreground : _colors.foreground) 
        : _colors.disabledForeground;
    
    if (widget.isLoading) {
      return SizedBox(
        width: widget.size.fontSize,
        height: widget.size.fontSize,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    }
    
    final children = <Widget>[];
    
    if (widget.icon != null) {
      children.add(widget.icon!);
    }
    
    children.add(Text(
      widget.text,
      style: TextStyle(
        fontSize: widget.size.fontSize,
        fontWeight: widget.size.fontWeight,
        color: textColor,
        letterSpacing: 0, // Zero tracking
        height: 1.3, // Snug line height
      ),
    ));
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
```

### Icon Button

```dart
class KyronIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final ButtonVariant variant;
  final bool isLoading;
  final bool isDisabled;
  
  const KyronIconButton({
    required this.icon,
    this.onPressed,
    this.size = ButtonSize.small,
    this.variant = ButtonVariant.solidPrimary,
    this.isLoading = false,
    this.isDisabled = false,
  });
  
  @override
  Widget build(BuildContext context) {
    return KyronButton(
      text: '',
      icon: icon,
      onPressed: onPressed,
      size: size,
      variant: variant,
      isLoading: isLoading,
      isDisabled: isDisabled,
      padding: EdgeInsets.all(size.paddingVertical),
    );
  }
}
```

---

## 🎯 Button Usage Examples

### Primary Button

```dart
KyronButton(
  text: 'Post',
  onPressed: () {
    // Submit post
  },
  variant: ButtonVariant.solidPrimary,
  size: ButtonSize.large,
)
```

### Secondary Button

```dart
KyronButton(
  text: 'Cancel',
  onPressed: () {
    // Cancel action
  },
  variant: ButtonVariant.solidSecondary,
  size: ButtonSize.large,
)
```

### Outlined Button

```dart
KyronButton(
  text: 'Outline',
  onPressed: () {
    // Action
  },
  variant: ButtonVariant.outlined,
  size: ButtonSize.large,
)
```

### Text Button

```dart
KyronButton(
  text: 'Text',
  onPressed: () {
    // Action
  },
  variant: ButtonVariant.text,
  size: ButtonSize.large,
)
```

### Icon Button

```dart
KyronIconButton(
  icon: Icon(Iconsax.heart, size: 20),
  onPressed: () {
    // Like action
  },
  variant: ButtonVariant.solidPrimary,
  size: ButtonSize.small,
)
```

### Button with Icon

```dart
KyronButton(
  text: 'Like',
  icon: Icon(Iconsax.heart, size: 16),
  onPressed: () {
    // Like action
  },
  size: ButtonSize.large,
)
```

### Small Button

```dart
KyronButton(
  text: 'Small',
  onPressed: () {
    // Action
  },
  size: ButtonSize.small,
)
```

### Tiny Button

```dart
KyronButton(
  text: 'Tiny',
  onPressed: () {
    // Action
  },
  size: ButtonSize.tiny,
)
```

### Loading Button

```dart
KyronButton(
  text: 'Submit',
  onPressed: null, // Disabled when loading
  isLoading: true,
)
```

### Disabled Button

```dart
KyronButton(
  text: 'Disabled',
  onPressed: null,
  isDisabled: true,
)
```

---

## 📱 Button States

### Normal State

- Scale: 1.0
- Opacity: 1.0
- Background: Variant color
- Foreground: Variant text color

### Pressed State

- Scale: 0.97
- Opacity: 0.85
- Background: Variant pressed color
- Foreground: Variant text color (or pressed color)
- **Haptic**: Light impact fired on touch-down

### Disabled State

- Scale: 1.0
- Opacity: 1.0
- Background: Variant disabled background
- Foreground: Variant disabled foreground
- **No haptic** on press

### Loading State

- Scale: 1.0
- Opacity: 1.0
- Background: Variant disabled background
- Foreground: Variant disabled foreground
- **Spinner**: Centered circular progress indicator
- **No haptic** on press

---

## 🌐 Responsive Buttons

### Full-Width Button

```dart
KyronButton(
  text: 'Full Width',
  onPressed: () {},
  width: double.infinity,
)
```

### Fixed-Width Button

```dart
KyronButton(
  text: 'Fixed',
  onPressed: () {},
  width: 200,
)
```

### Adaptive Sizing

```dart
// Adapt button size based on screen width
ButtonSize get adaptiveButtonSize(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  
  if (width < 360) {
    return ButtonSize.small;
  } else if (width < 480) {
    return ButtonSize.large;
  } else {
    return ButtonSize.large;
  }
}
```

---

## ♿ Accessibility

### Touch Targets

All buttons meet **minimum 44×44 touch target** requirements:

- **Large**: 48px minimum height, ample padding
- **Small**: 40px minimum height (close to 44px)
- **Tiny**: 32px minimum height (**needs padding**)

**For Tiny buttons, add padding:**

```dart
KyronIconButton(
  icon: Icon(Iconsax.heart, size: 16),
  onPressed: () {},
  size: ButtonSize.tiny,
  padding: EdgeInsets.all(12), // Makes it 32 + 24 = 56px
)
```

### Semantics

All buttons have proper semantics:

```dart
Semantics(
  button: true,
  enabled: isEnabled,
  label: widget.text,
  child: ...
)
```

### Focus Management

```dart
Focus(
  focusNode: _focusNode,
  onFocusChange: (hasFocus) {
    setState(() => _hasFocus = hasFocus);
  },
  child: ...
)
```

---

## 🧪 Testing Buttons

### Test Checklist

1. **Visual**: Verify pill shape, colors, sizes
2. **Interaction**: Verify press state (scale + opacity)
3. **Haptics**: Verify haptic fires on touch-down
4. **Accessibility**: Verify touch targets, semantics
5. **States**: Verify all states (normal, pressed, disabled, loading)
6. **Variants**: Verify all variants
7. **Sizes**: Verify all sizes
8. **Platform**: Test on iOS, Android, Web

### Test Cases

```dart
// Test press animation
void testPressAnimation() {
  final button = KyronButton(text: 'Test', onPressed: () {});
  
  // Simulate press
  // Verify scale changes to 0.97
  // Verify opacity changes to 0.85
}

// Test haptic
void testHaptic() {
  // Mock Haptics.light()
  // Verify it's called on touch down
}

// Test touch target
void testTouchTarget() {
  final button = KyronButton(text: 'Test', onPressed: () {});
  
  // Measure rendered size
  // Verify minimum 44px in both dimensions
}
```

---

## 📊 Button Token Export

For programmatic access:

```json
{
  "buttons": {
    "sizes": {
      "large": {
        "paddingVertical": 12,
        "paddingHorizontal": 24,
        "gap": 6,
        "fontSize": 15,
        "fontWeight": "medium",
        "minHeight": 48
      },
      "small": {
        "paddingVertical": 8,
        "paddingHorizontal": 14,
        "gap": 5,
        "fontSize": 13.1,
        "fontWeight": "medium",
        "minHeight": 40
      },
      "tiny": {
        "paddingVertical": 5,
        "paddingHorizontal": 10,
        "gap": 3,
        "fontSize": 11.3,
        "fontWeight": "semibold",
        "minHeight": 32
      }
    },
    "variants": {
      "solidPrimary": {
        "background": "primary_500",
        "foreground": "#FFFFFF",
        "pressedBackground": "primary_600",
        "disabledBackground": "primary_200",
        "disabledForeground": "#FFFFFFCC"
      },
      "solidSecondary": {
        "background": "contrast_50",
        "foreground": "contrast_1000",
        "pressedBackground": "contrast_100",
        "disabledBackground": "contrast_200",
        "disabledForeground": "contrast_700CC"
      },
      "solidNegative": {
        "background": "negative_600",
        "foreground": "#FFFFFF",
        "pressedBackground": "negative_700",
        "disabledBackground": "negative_800",
        "disabledForeground": "#FFFFFFCC"
      },
      "outlined": {
        "background": "transparent",
        "foreground": "primary_500",
        "border": "primary_500",
        "pressedBackground": "primary_50",
        "disabledBackground": "transparent",
        "disabledForeground": "primary_200",
        "disabledBorder": "primary_200"
      },
      "text": {
        "background": "transparent",
        "foreground": "primary_500",
        "pressedBackground": "primary_50",
        "disabledBackground": "transparent",
        "disabledForeground": "primary_200"
      }
    },
    "press": {
      "scale": 0.97,
      "opacity": 0.85,
      "duration": 90,
      "haptic": "light"
    }
  }
}
```

---

## 🔗 References

- [Bluesky Button Component](https://github.com/bluesky-social/social-app/blob/main/src/components/Button.tsx)
- [Flutter ElevatedButton](https://api.flutter.dev/flutter/material/ElevatedButton-class.html)
- [Material Design Buttons](https://m3.material.io/components/buttons/overview)
- [Button Accessibility](https://www.w3.org/WAI/ARIA/apg/patterns/button/)

---

*"A button should look like a button, feel like a button, and work like a button."*

**Button System Documentation** — Version 1.0 — Kyron Design System
