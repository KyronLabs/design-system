# Haptics System

## ⚡ The Critical Finding

From Bluesky's `src/lib/haptics.ts`:

```typescript
// Users said the medium impact was too strong on Android; see APP-537
const style = isIOS ? ImpactFeedbackStyle[strength] : ImpactFeedbackStyle.Light
```

**Android clamps every impact to Light.** This is the **single most important haptics detail** in the entire app.

### Why This Matters

Most Flutter apps feel "buzzy" on Android because:
- `HapticFeedback.mediumImpact()` on Android maps to a **much heavier** vibration than iOS taptic
- Android's haptic feedback is **inconsistent** across devices
- Users **notice** and **dislike** heavy haptics on Android

**Solution**: Clamp all impacts to **Light** on Android.

---

## 🎯 Haptics Philosophy

### Core Principles

1. **Platform-Aware**: Different behavior on iOS vs Android vs Web
2. **Subtle**: Haptics should be felt, not heard
3. **Intentional**: Only fire for meaningful interactions
4. **Rate-Limited**: Prevent continuous buzzing
5. **User-Controlled**: Users can disable haptics
6. **Context-Aware**: Different haptics for different interactions

### The Golden Rule

> **Fire on touch-down, not on tap-up.**

Perceived latency is dominated by **when the haptic lands**, not when the visual lands. Firing on touch-down makes the interface feel **instant** and **responsive**.

---

## 📱 Platform Implementation

### Flutter Implementation

```dart
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

class Haptics {
  static const Duration _throttleDuration = Duration(milliseconds: 40);
  static DateTime? _lastTickTime;
  
  /// Android clamps all impacts to Light
  static ImpactFeedbackStyle _getStyle(ImpactFeedbackStyle style) {
    if (Platform.isAndroid) {
      return ImpactFeedbackStyle.light;
    }
    return style;
  }
  
  /// Fire a light impact
  static void light() {
    if (Platform.isIOS || Platform.isAndroid) {
      HapticFeedback.lightImpact();
    }
    // Web: no haptics
  }
  
  /// Fire a medium impact (clamped to light on Android)
  static void medium() {
    if (Platform.isIOS) {
      HapticFeedback.mediumImpact();
    } else if (Platform.isAndroid) {
      HapticFeedback.lightImpact(); // Clamped!
    }
  }
  
  /// Fire a heavy impact (clamped to light on Android)
  static void heavy() {
    if (Platform.isIOS) {
      HapticFeedback.heavyImpact();
    } else if (Platform.isAndroid) {
      HapticFeedback.lightImpact(); // Clamped!
    }
  }
  
  /// Fire a micro-haptic tick (rate-limited)
  static void tick() {
    final now = DateTime.now();
    if (_lastTickTime != null && 
        now.difference(_lastTickTime!) < _throttleDuration) {
      return; // Rate-limited
    }
    _lastTickTime = now;
    
    if (Platform.isIOS || Platform.isAndroid) {
      HapticFeedback.lightImpact();
    }
  }
  
  /// Fire a selection haptic
  static void select() {
    if (Platform.isIOS) {
      HapticFeedback.selectionClick();
    } else if (Platform.isAndroid) {
      HapticFeedback.lightImpact();
    }
  }
  
  /// Fire a success pattern (two pulses with gap)
  static Future<void> success() async {
    if (Platform.isIOS || Platform.isAndroid) {
      tick();
      await Future.delayed(Duration(milliseconds: 90));
      tick();
    }
  }
  
  /// Fire an error pattern
  static void error() {
    if (Platform.isIOS) {
      HapticFeedback.heavyImpact();
    } else if (Platform.isAndroid) {
      HapticFeedback.lightImpact();
    }
  }
}
```

### Usage Examples

```dart
// Button press
ElevatedButton(
  onPressed: () {
    Haptics.light(); // Fire on press
    // ... action
  },
  child: Text('Button'),
)

// Toggle switch
Switch(
  value: isOn,
  onChanged: (value) {
    Haptics.tick(); // Rate-limited micro-haptic
    setState(() => isOn = value);
  },
)

// Selection
ListTile(
  title: Text('Item'),
  onTap: () {
    Haptics.select();
    // ... select item
  },
)

// Success feedback
Future<void> likePost() async {
  // Optimistic update
  setState(() => isLiked = true);
  
  try {
    await api.likePost(postId);
    await Haptics.success(); // Two pulses with gap
  } catch (e) {
    Haptics.error();
    // Rollback
    setState(() => isLiked = false);
  }
}
```

---

## 🎚️ Haptic Strengths

### Strength Levels

| Level | iOS | Android | Usage |
|-------|-----|---------|-------|
| Micro | Light | Light | Selection ticks, small interactions |
| Light | Light | Light | Most interactions |
| Medium | Medium | **Light** | Important actions |
| Heavy | Heavy | **Light** | Critical actions, errors |

### When to Use Each

**Micro (Tick):**
- Selection changes (radio buttons, switches)
- Small state changes
- Page navigation (tab switches)
- Rate-limited to prevent buzzing

**Light:**
- Button presses
- Icon taps
- List item selections
- Most common haptic

**Medium:**
- Important button presses (submit, confirm)
- Destructive actions
- Modal presentations
- **Clamped to Light on Android**

**Heavy:**
- Critical errors
- Important confirmations
- **Clamped to Light on Android**

---

## ⏱️ Timing Rules

### Rule 1: Fire on Touch-Down

**Always fire haptics on touch-down, not tap-up.**

```dart
// ✅ CORRECT: Fire on touch down
GestureDetector(
  onTapDown: (_) {
    Haptics.light();
  },
  onTap: () {
    // Action
  },
  child: ...
)

// ❌ INCORRECT: Fire on tap up
GestureDetector(
  onTap: () {
    Haptics.light(); // Too late!
    // Action
  },
  child: ...
)
```

### Rule 2: Rate-Limit Micro-Haptics

**Micro-haptics must be rate-limited to prevent continuous buzzing.**

```dart
// ✅ CORRECT: Rate-limited
static DateTime? _lastTickTime;
static const _throttleDuration = Duration(milliseconds: 40);

void tick() {
  final now = DateTime.now();
  if (_lastTickTime != null && 
      now.difference(_lastTickTime!) < _throttleDuration) {
    return; // Skip if too recent
  }
  _lastTickTime = now;
  HapticFeedback.lightImpact();
}
```

**Why 40ms?**
- A selection tick fired on every page-view frame (16ms) would create a continuous buzz
- A selection tick fired on every character of an amount field would buzz continuously
- 40ms provides a good balance: fast enough for rapid interactions, slow enough to prevent buzzing

### Rule 3: Compound Patterns Need Gaps

**A "success" pattern that fires two impacts back-to-back reads as one smeared buzz.**

```dart
// ✅ CORRECT: 90ms gap between pulses
Future<void> success() async {
  Haptics.tick();
  await Future.delayed(Duration(milliseconds: 90));
  Haptics.tick();
}

// ❌ INCORRECT: No gap
void successWrong() {
  Haptics.tick();
  Haptics.tick(); // Reads as one buzz
}
```

**Why 90ms?**
- Below 90ms, two taps read as one smeared buzz
- At 90ms, two taps read as two distinct taps
- This is the **floor** for distinguishable pulses

---

## 🔕 User Control

### Disable Haptics

Users should be able to disable haptics entirely.

```dart
// Settings
bool hapticsEnabled = true;

// Usage
void likePost() {
  if (hapticsEnabled) {
    Haptics.light();
  }
  // ...
}
```

### Persistence

```dart
// Save preference
SharedPreferences prefs = await SharedPreferences.getInstance();
await prefs.setBool('hapticsEnabled', value);

// Load preference
bool hapticsEnabled = prefs.getBool('hapticsEnabled') ?? true;
```

### System-Level Control

Respect system-level haptic settings:

```dart
// Check if system haptics are enabled
// Note: Flutter doesn't have direct access, but we can infer
bool systemHapticsEnabled = true; // Default

// On iOS, check if device has haptic engine
if (Platform.isIOS) {
  // iPhone 7 and later have haptic engine
  // This is a simplification
  systemHapticsEnabled = true;
}
```

---

## 🌐 Platform Differences

### iOS

- **Full haptic range**: Light, Medium, Heavy all available
- **Taptic Engine**: Precise, consistent haptics
- **Selection Click**: Special haptic for selection
- **Notification Feedback**: Special haptic for notifications

### Android

- **All impacts clamped to Light**: Critical for good UX
- **Vibration API**: Less precise than iOS
- **Device variation**: Haptics vary significantly across devices
- **No selection click**: Use light impact instead

### Web

- **No haptics**: Web browsers don't support vibration for UX
- **Silent**: All haptic calls are no-ops
- **Fallback**: Consider visual feedback instead

---

## 🎯 Haptic Patterns

### Standard Patterns

| Pattern | Usage | Implementation |
|---------|-------|----------------|
| **Tick** | Selection, small state change | `Haptics.tick()` (rate-limited) |
| **Light** | Button press, icon tap | `Haptics.light()` |
| **Medium** | Important action | `Haptics.medium()` (clamped on Android) |
| **Heavy** | Critical action, error | `Haptics.heavy()` (clamped on Android) |
| **Success** | Successful operation | Two ticks with 90ms gap |
| **Error** | Failed operation | Heavy impact (clamped on Android) |
| **Selection** | Item selection | `Haptics.select()` |

### Custom Patterns

```dart
// Loading complete
Future<void> loadingComplete() async {
  Haptics.light();
  await Future.delayed(Duration(milliseconds: 50));
  Haptics.light();
}

// Important notification
Future<void> importantNotification() async {
  Haptics.medium();
  await Future.delayed(Duration(milliseconds: 100));
  Haptics.light();
}

// Countdown tick
void countdownTick() {
  Haptics.tick(); // Rate-limited automatically
}

// Pull to refresh
Future<void> pullToRefresh() async {
  // At trigger point
  Haptics.light();
  
  // On release
  await Future.delayed(Duration(milliseconds: 200));
  Haptics.light();
}
```

---

## 📊 Haptic Usage Guidelines

### When to Use Haptics

✅ **Do use haptics for:**
- Button presses
- Icon taps
- Toggle switches
- Selection changes
- Important state changes
- Successful operations
- Error states
- Pull to refresh
- Swipe actions
- Long press actions

❌ **Don't use haptics for:**
- Scrolling
- Page loads (automatic)
- Background sync
- Non-interactive elements
- Every frame of animation
- Rapid, repeated interactions (without rate limiting)

### Haptic Intensity Guide

| Interaction | Haptic Strength |
|-------------|------------------|
| Small button tap | Light |
| Large button tap | Light |
| Icon tap | Light |
| Switch toggle | Tick (rate-limited) |
| Radio button select | Tick (rate-limited) |
| Checkbox toggle | Tick (rate-limited) |
| List item tap | Light |
| Modal presentation | Medium |
| Modal dismissal | Light |
| Pull to refresh trigger | Light |
| Pull to refresh release | Light |
| Swipe action | Light |
| Long press start | Light |
| Long press end | Light |
| Success feedback | Success pattern |
| Error feedback | Error pattern |

---

## 🧪 Testing Haptics

### Test Checklist

1. **Platform Testing**: Test on both iOS and Android
2. **Device Testing**: Test on multiple devices (haptics vary)
3. **Rate Limiting**: Verify micro-haptics are rate-limited
4. **Timing**: Verify haptics fire on touch-down
5. **User Control**: Verify haptics can be disabled
6. **Pattern Testing**: Verify compound patterns have proper gaps
7. **Performance**: Verify haptics don't cause jank

### Test Cases

```dart
// Test rate limiting
void testRateLimiting() {
  for (int i = 0; i < 10; i++) {
    Haptics.tick(); // Only first should fire
  }
}

// Test compound pattern
Future<void> testSuccessPattern() async {
  final stopwatch = Stopwatch()..start();
  await Haptics.success();
  stopwatch.stop();
  expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(90));
}

// Test platform clamping
void testPlatformClamping() {
  if (Platform.isAndroid) {
    // All impacts should be light
    expect(Haptics._getStyle(ImpactFeedbackStyle.medium), 
        ImpactFeedbackStyle.light);
    expect(Haptics._getStyle(ImpactFeedbackStyle.heavy), 
        ImpactFeedbackStyle.light);
  }
}
```

---

## 📚 References

- [Bluesky Haptics Implementation](https://github.com/bluesky-social/social-app/blob/main/src/lib/haptics.ts)
- [Flutter HapticFeedback](https://api.flutter.dev/flutter/services/HapticFeedback-class.html)
- [iOS UIImpactFeedbackGenerator](https://developer.apple.com/documentation/uikit/uiimpactfeedbackgenerator)
- [Android Vibrator](https://developer.android.com/reference/android/os/Vibrator)
- [APP-537: Medium impact too strong on Android](https://github.com/bluesky-social/social-app/issues/537)

---

*"Haptics are the difference between tapping glass and pressing a button."*

**Haptics System Documentation** — Version 1.0 — Kyron Design System
