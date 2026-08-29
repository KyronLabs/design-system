# Motion System

## 🎯 Motion Philosophy

Kyron's motion system is **fast, subtle, and purposeful**. Every animation serves a clear purpose: to communicate state changes, guide attention, or provide feedback.

### Core Principles

1. **Short Durations**: Anything over ~300ms reads as sluggish
2. **Scale + Opacity**: Press states use scale (0.97) + opacity (0.85)
3. **Platform-Native**: Use platform-native transitions where possible
4. **No Ripples**: Disable Material ink ripples (`splashFactory: NoSplash`)
5. **Performance**: All animations must run at 60fps

---

## ⏱️ Duration Scale

From Bluesky's implementation:

```
micro  90ms   press-state changes
fast   180ms  sheets closing, chips
normal 260ms  page pushes, sheet opening
slow   420ms  hero / count-up
```

| Name | Duration | Usage |
|------|----------|-------|
| `motion_micro` | 90ms | Press state changes, micro-interactions |
| `motion_fast` | 180ms | Sheets closing, chips, quick transitions |
| `motion_normal` | 260ms | Page pushes, sheet opening, standard transitions |
| `motion_slow` | 420ms | Hero animations, count-up, complex transitions |

### Flutter Implementation

```dart
// Duration constants
const motionMicro = Duration(milliseconds: 90);
const motionFast = Duration(milliseconds: 180);
const motionNormal = Duration(milliseconds: 260);
const motionSlow = Duration(milliseconds: 420);

// Easing curves
const easeOut = Curves.easeOut;
const easeInOut = Curves.easeInOut;
const easeOutBack = Curves.easeOutBack;
const fastOutSlowIn = Curves.fastOutSlowIn;
```

---

## 🔄 Press Interaction

### The Bluesky Press Model

Bluesky uses **scale + opacity** for press states, which is what React Native's `Pressable` does by default. This is different from Material's ink ripple.

**Press States:**
- **Normal**: Scale 1.0, Opacity 1.0
- **Pressed**: Scale 0.97, Opacity 0.85
- **Disabled**: Opacity 0.5 (no scale change)

### Flutter Implementation

```dart
// Custom pressable widget
class Pressable extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Duration duration;
  
  const Pressable({
    required this.child,
    this.onPressed,
    this.duration = motionMicro,
  });
  
  @override
  _PressableState createState() => _PressableState();
}

class _PressableState extends State<Pressable> {
  bool _isPressed = false;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed?.call();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        duration: widget.duration,
        scale: _isPressed ? 0.97 : 1.0,
        child: AnimatedOpacity(
          duration: widget.duration,
          opacity: _isPressed ? 0.85 : 1.0,
          child: widget.child,
        ),
      ),
    );
  }
}

// Usage
Pressable(
  onPressed: () {
    // Action
  },
  child: Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text('Press me'),
  ),
)
```

### Button Press Animation

```dart
// ElevatedButton with press animation
ElevatedButton.styleFrom(
  // No splash (disable ripple)
  splashFactory: NoSplash.splashFactory,
  // Custom animation
  animationDuration: motionMicro,
)

// Or custom implementation
class AnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  
  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isPressed = false;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: motionMicro,
        transform: Matrix4.identity()..scale(_isPressed ? 0.97 : 1.0),
        transformAlignment: Alignment.center,
        child: Opacity(
          opacity: _isPressed ? 0.85 : 1.0,
          child: widget.child,
        ),
      ),
    );
  }
}
```

---

## 📱 Navigation Transitions

### Stack Navigator (Push/Pop)

Bluesky uses **platform-native push** transitions:
- **iOS**: Horizontal slide with parallax on outgoing screen
- **Android**: Predictive back with slide
- **Web**: Fade or slide (browser-dependent)

**Flutter Implementation:**

```dart
// Custom page transition
class SlideTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    // iOS-style slide with parallax
    if (Platform.isIOS) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        )),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0.0, 0.0),
            end: Offset(-0.3, 0.0), // Parallax effect
          ).animate(CurvedAnimation(
            parent: secondaryAnimation,
            curve: Curves.easeOut,
          )),
          child: child,
        ),
      );
    }
    
    // Android-style slide
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      )),
      child: child,
    );
  }
}

// Usage
MaterialApp(
  theme: ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: SlideTransitionBuilder(),
        TargetPlatform.android: SlideTransitionBuilder(),
      },
    ),
  ),
)
```

### Tab Switching

Bluesky uses **cross-fade** for tab switches with **no travel** (no horizontal movement).

**Flutter Implementation:**

```dart
// Tab switch animation
class TabSwitchTransition extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}

// Usage with CupertinoTabBar
CupertinoTabScaffold(
  tabBuilder: (context, index) {
    return CupertinoPageScaffold(
      child: _pages[index],
    );
  },
  tabBar: CupertinoTabBar(
    items: [...],
  ),
)
```

### Bottom Sheet Animation

**Opening:** Normal (260ms) with parallax on outgoing screen
**Closing:** Fast (180ms)

```dart
// Custom bottom sheet animation
showModalBottomSheet(
  context: context,
  transitionAnimationController: AnimationController(
    vsync: Navigator.of(context),
    duration: motionNormal, // 260ms
  ),
  animationCurve: Curves.easeOut,
  barrierColor: Colors.black.withOpacity(0.5),
  builder: (context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [...],
    );
  },
);

// Custom animation
Future<void> showCustomBottomSheet(BuildContext context) async {
  final controller = AnimationController(
    vsync: Navigator.of(context),
    duration: motionNormal,
  );
  
  final animation = CurvedAnimation(
    parent: controller,
    curve: Curves.easeOut,
  );
  
  await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    transitionDuration: motionNormal,
    pageBuilder: (context, anim1, anim2) => Container(),
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(anim1),
        child: child,
      );
    },
  );
  
  controller.forward();
}
```

---

## 🎭 Common Animations

### 1. Fade In/Out

```dart
// Simple fade
AnimatedOpacity(
  opacity: _visible ? 1.0 : 0.0,
  duration: motionFast,
  curve: Curves.easeOut,
  child: widget,
)

// Fade with slide
AnimatedSlide(
  offset: _visible ? Offset.zero : Offset(0.0, 20.0),
  duration: motionNormal,
  curve: Curves.easeOut,
  child: AnimatedOpacity(
    opacity: _visible ? 1.0 : 0.0,
    duration: motionNormal,
    child: widget,
  ),
)
```

### 2. Scale Animation

```dart
// Scale in
AnimatedScale(
  scale: _visible ? 1.0 : 0.9,
  duration: motionFast,
  curve: Curves.easeOutBack,
  child: widget,
)

// Bounce effect
AnimatedScale(
  scale: _pressed ? 0.95 : 1.0,
  duration: motionMicro,
  curve: Curves.easeOut,
  child: widget,
)
```

### 3. Slide Animation

```dart
// Slide from right
AnimatedSlide(
  offset: _visible ? Offset.zero : Offset(1.0, 0.0),
  duration: motionNormal,
  curve: Curves.easeOut,
  child: widget,
)

// Slide from bottom
AnimatedSlide(
  offset: _visible ? Offset.zero : Offset(0.0, 1.0),
  duration: motionNormal,
  curve: Curves.easeOut,
  child: widget,
)
```

### 4. Count-Up Animation

```dart
// Animated counter
class AnimatedCounter extends StatefulWidget {
  final int count;
  final Duration duration;
  
  const AnimatedCounter({
    required this.count,
    this.duration = motionSlow, // 420ms
  });
  
  @override
  _AnimatedCounterState createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter> {
  int _displayCount = 0;
  late AnimationController _controller;
  late Animation<int> _animation;
  
  @override
  void initState() {
    super.initState();
    _displayCount = widget.count;
    
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    
    _animation = IntTween(
      begin: _displayCount,
      end: widget.count,
    ).animate(_controller);
    
    _animation.addListener(() {
      setState(() => _displayCount = _animation.value);
    });
    
    _controller.forward();
  }
  
  @override
  Widget build(BuildContext context) {
    return Text('$_displayCount');
  }
  
  @override
  void didUpdateWidget(AnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.count != widget.count) {
      _animation = IntTween(
        begin: _displayCount,
        end: widget.count,
      ).animate(_controller);
      _controller.forward(from: 0.0);
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### 5. Hero Animation

```dart
// Hero animation with custom duration
Hero(
  tag: 'image-$id',
  flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
    return FadeTransition(
      opacity: animation,
      child: toHeroContext.widget,
    );
  },
  transitionOnUserGestures: true,
  child: Image.network(url),
)

// Custom hero duration
MaterialApp(
  theme: ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: _CustomPageTransitionsBuilder(),
        TargetPlatform.android: _CustomPageTransitionsBuilder(),
      },
    ),
  ),
)
```

---

## 🎯 Animation Guidelines

### When to Animate

✅ **Do animate:**
- State changes (pressed, selected, enabled/disabled)
- Transitions between screens
- Appearance/disappearance of elements
- Loading states
- Success/error feedback
- Reordering of lists

❌ **Don't animate:**
- Every frame of scrolling
- Text input (cursor blinking is fine)
- System chrome (status bar, navigation bar)
- Background processes
- Non-visible changes

### Animation Quality

1. **60fps**: All animations must run at 60fps
2. **Smooth**: No jank or dropped frames
3. **Appropriate Duration**: Use the duration scale
4. **Appropriate Easing**: Use curves that feel natural
5. **Purposeful**: Every animation should have a clear purpose

---

## 📱 Platform-Specific Motion

### iOS

- **Navigation**: Horizontal slide with parallax
- **Modals**: Slide up from bottom
- **Haptics**: Full range available
- **Scroll Physics**: iOS-style bounce

### Android

- **Navigation**: Predictive back with slide
- **Modals**: Slide up from bottom or fade
- **Haptics**: All clamped to Light
- **Scroll Physics**: Android-style over-scroll

### Web

- **Navigation**: Browser-native (back/forward)
- **Modals**: Fade or slide (browser-dependent)
- **Haptics**: None
- **Scroll Physics**: Web-style smooth scrolling

---

## ♿ Accessibility

### Reduced Motion

Respect the user's reduced motion preference:

```dart
// Check for reduced motion
bool get reducedMotion => 
    MediaQuery.of(context).prefersReducedMotion;

// Usage
AnimatedContainer(
  duration: reducedMotion ? Duration.zero : motionNormal,
  curve: reducedMotion ? Curves.linear : Curves.easeOut,
  child: ...
)

// Or disable animations entirely
if (reducedMotion) {
  return widget; // No animation
}
return AnimatedWidget(...);
```

### Animation Alternatives

For users with reduced motion, provide alternatives:

```dart
// Fade vs instant
Widget build(BuildContext context) {
  if (MediaQuery.of(context).prefersReducedMotion) {
    return _visible ? widget : SizedBox.shrink();
  }
  return AnimatedOpacity(
    opacity: _visible ? 1.0 : 0.0,
    duration: motionFast,
    child: widget,
  );
}
```

---

## 🧪 Testing Motion

### Test Checklist

1. **Performance**: Verify 60fps on target devices
2. **Durations**: Verify durations match the scale
3. **Easing**: Verify curves feel natural
4. **Platform**: Test on iOS, Android, and Web
5. **Reduced Motion**: Verify reduced motion works
6. **Interruptions**: Verify animations handle interruptions
7. **Chaining**: Verify chained animations work correctly

### Performance Testing

```dart
// Measure frame times
void testAnimationPerformance() {
  final stopwatch = Stopwatch()..start();
  final frames = <int>[];
  
  // Run animation and measure each frame
  for (int i = 0; i < 60; i++) {
    // Simulate frame
    frames.add(stopwatch.elapsedMilliseconds);
    await Future.delayed(Duration(milliseconds: 16)); // 60fps
  }
  
  stopwatch.stop();
  
  // Calculate average frame time
  final avgFrameTime = frames.reduce((a, b) => a + b) / frames.length;
  print('Average frame time: ${avgFrameTime}ms');
  
  // Should be close to 16ms for 60fps
  expect(avgFrameTime, lessThan(20));
}
```

---

## 📊 Motion Token Export

For programmatic access:

```json
{
  "motion": {
    "durations": {
      "micro": 90,
      "fast": 180,
      "normal": 260,
      "slow": 420
    },
    "easing": {
      "easeOut": "cubic-bezier(0.215, 0.610, 0.355, 1.000)",
      "easeInOut": "cubic-bezier(0.420, 0.000, 0.580, 1.000)",
      "easeOutBack": "cubic-bezier(0.120, 0.000, 0.390, 1.195)",
      "fastOutSlowIn": "cubic-bezier(0.400, 0.000, 0.200, 1.000)"
    },
    "transitions": {
      "press": {
        "scale": 0.97,
        "opacity": 0.85,
        "duration": 90
      },
      "pagePush": {
        "type": "slide",
        "direction": "right",
        "duration": 260,
        "easing": "easeOut"
      },
      "pagePop": {
        "type": "slide",
        "direction": "left",
        "duration": 260,
        "easing": "easeOut"
      },
      "tabSwitch": {
        "type": "fade",
        "duration": 180,
        "easing": "easeOut"
      },
      "sheetOpen": {
        "type": "slide",
        "direction": "bottom",
        "duration": 260,
        "easing": "easeOut"
      },
      "sheetClose": {
        "type": "slide",
        "direction": "bottom",
        "duration": 180,
        "easing": "easeOut"
      }
    }
  }
}
```

---

## 🔗 References

- [Bluesky Motion Implementation](https://github.com/bluesky-social/social-app/blob/main/src/alf/themes.ts)
- [Flutter Animation](https://docs.flutter.dev/ui/animations/overview)
- [Material Motion Guidelines](https://m3.material.io/styles/motion/overview)
- [iOS Animation Guidelines](https://developer.apple.com/design/human-interface-guidelines/patterns/animation/)
- [Android Motion Guidelines](https://developer.android.com/design/ui/motion)

---

*"Motion should be meaningful, not just decorative."*

**Motion System Documentation** — Version 1.0 — Kyron Design System
