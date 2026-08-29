# Accessibility Guidelines

## ♿ Accessibility Philosophy

Kyron is committed to **inclusive design** — creating experiences that work for everyone, regardless of ability. Accessibility is not an afterthought; it's a core principle that guides every design and development decision.

### Core Principles

1. **Inclusive by Default**: Design for the broadest possible audience from the start
2. **WCAG 2.1 AA Compliance**: Meet or exceed Web Content Accessibility Guidelines
3. **Platform-Specific Standards**: Follow iOS, Android, and Web accessibility best practices
4. **Continuous Testing**: Test with assistive technologies throughout development
5. **Education**: Ensure all team members understand accessibility fundamentals

---

## 🎯 WCAG 2.1 AA Checklist

### Perceivable

#### 1.1 Text Alternatives
- ✅ **Provide text alternatives** for all non-text content
- ✅ **Decorative images** have empty alt text (`alt=""`)
- ✅ **Functional images** have descriptive alt text
- ✅ **Icons** have text labels or ARIA labels
- ✅ **SVG graphics** have accessible descriptions

**Implementation:**
```dart
// Image with alt text
Image.network(
  'https://example.com/image.jpg',
  semanticLabel: 'A beautiful sunset over the ocean',
)

// Icon button with label
IconButton(
  icon: Icon(Iconsax.heart),
  tooltip: 'Like this post',
  onPressed: () {},
)

// SVG with description
SvgPicture.asset(
  'assets/logo.svg',
  semanticsLabel: 'Kyron Logo',
)
```

#### 1.2 Adaptable
- ✅ **Content structure** is preserved when CSS is disabled
- ✅ **Reading order** is logical and meaningful
- ✅ **Text alternatives** can be programmatically determined

#### 1.3 Distinguishable
- ✅ **Color contrast** minimum 4.5:1 for normal text
- ✅ **Color contrast** minimum 3:1 for large text (18.66px+)
- ✅ **Color is not the only** visual means of conveying information
- ✅ **Text can be resized** up to 200% without loss of content or functionality

**Color Contrast Examples:**
```
Light Theme:
- Primary text: contrast_1000 (#000000) on contrast_0 (#FFFFFF) = 21:1 ✅
- Secondary text: contrast_700 (#5C5C5C) on contrast_0 (#FFFFFF) = 7.5:1 ✅
- Tertiary text: contrast_400 (#B0B0B0) on contrast_0 (#FFFFFF) = 4.5:1 ✅
- Accent: primary_500 (#006AFF) on contrast_0 (#FFFFFF) = 4.6:1 ✅

Dark Theme:
- Primary text: contrast_1000 (#FFFFFF) on contrast_0 (#000000) = 21:1 ✅
- Secondary text: contrast_700 (#B0B0B0) on contrast_0 (#000000) = 7.5:1 ✅
- Tertiary text: contrast_400 (#5C5C5C) on contrast_0 (#000000) = 4.5:1 ✅
```

#### 1.4 Audio & Video
- ✅ **Captions** provided for all pre-recorded audio
- ✅ **Transcripts** provided for all pre-recorded audio and video
- ✅ **Audio descriptions** for video with visual information
- ✅ **Sign language** interpretation for audio content

### Operable

#### 2.1 Keyboard Accessible
- ✅ **All functionality** available via keyboard
- ✅ **Focus indicators** visible for all interactive elements
- ✅ **Logical tab order** that preserves meaning
- ✅ **Skip links** provided for long pages

**Flutter Implementation:**
```dart
// Focusable widget with custom focus decoration
Focus(
  focusNode: _focusNode,
  onFocusChange: (hasFocus) {
    setState(() => _hasFocus = hasFocus);
  },
  child: Container(
    decoration: BoxDecoration(
      border: _hasFocus 
          ? Border.all(color: KyronTheme.accent, width: 2) 
          : null,
      borderRadius: BorderRadius.circular(RadiusTokens.radius12),
    ),
    child: ...
  ),
)

// Keyboard navigation
Shortcuts(
  shortcuts: {
    LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
    LogicalKeySet(LogicalKeyboardKey.space): const ActivateIntent(),
  },
  child: Actions(
    actions: {
      ActivateIntent: CallbackAction(onInvoke: (_) => _onActivate()),
    },
    child: ElevatedButton(
      onPressed: _onActivate,
      child: Text('Button'),
    ),
  ),
)
```

#### 2.2 Enough Time
- ✅ **Time limits** can be extended or disabled
- ✅ **Moving content** can be paused, stopped, or hidden
- ✅ **Auto-playing audio** can be stopped or muted
- ✅ **Timeouts** are configurable or can be disabled

#### 2.3 Seizures
- ✅ **No content** flashes more than 3 times per second
- ✅ **No content** has flashing that could cause seizures

#### 2.4 Navigable
- ✅ **Page titles** describe topic or purpose
- ✅ **Link purpose** clear from text or context
- ✅ **Multiple ways** to locate content (search, navigation, etc.)
- ✅ **Headings and labels** describe topic or purpose
- ✅ **Focus order** preserves meaning and operability

**Flutter Implementation:**
```dart
// Semantic structure
Semantics(
  label: 'Post by user',
  child: Column(
    children: [
      Semantics(
        header: true,
        child: Text('User Name'),
      ),
      Text('Post content'),
    ],
  ),
)

// Descriptive link text
TextButton(
  onPressed: () => _openPost(post),
  child: Text('Read full post: ${post.title}'),
)
```

#### 2.5 Input Modalities
- ✅ **Pointer gestures** have alternatives
- ✅ **Down-event targets** have at least 44×44px touch area
- ✅ **Functionality** available through multiple input methods
- ✅ **Motion actuation** can be operated through other inputs

**Touch Targets:**
```dart
// Ensure minimum 44x44 touch target
InkWell(
  customBorder: CircleBorder(),
  child: Padding(
    padding: EdgeInsets.all(12), // 24px icon + 24px padding = 48px
    child: Icon(Iconsax.heart, size: 24),
  ),
)

// Button with sufficient size
ElevatedButton(
  style: ElevatedButton.styleFrom(
    minimumSize: Size(44, 44), // Minimum touch target
  ),
  child: Text('Tap'),
)
```

### Understandable

#### 3.1 Readable
- ✅ **Language** of page can be programmatically determined
- ✅ **Language changes** are identified
- ✅ **Abbreviations** are expanded or explained
- ✅ **Reading level** appropriate for audience

**Flutter Implementation:**
```dart
// Set text direction and locale
MaterialApp(
  locale: Locale('en', 'US'),
  supportedLocales: [Locale('en', 'US')],
  localizationsDelegates: [...],
  textDirection: TextDirection.ltr,
)

// Semantic text
Text(
  'KYRON',
  semanticsLabel: 'Kyron - The user-owned social stack',
)
```

#### 3.2 Predictable
- ✅ **Consistent navigation** throughout the app
- ✅ **Consistent identification** of components
- ✅ **Changes of context** only on user request or with warning

#### 3.3 Input Assistance
- ✅ **Error identification** with clear, descriptive messages
- ✅ **Labels or instructions** provided for user input
- ✅ **Error suggestions** for fixing input errors
- ✅ **Error prevention** through validation

**Form Validation:**
```dart
// Form with accessibility
Form(
  child: Column(
    children: [
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Email Address',
          hintText: 'Enter your email',
          errorText: _emailError,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email address';
          }
          if (!EmailValidator.validate(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
        onChanged: (value) => _validateEmail(value),
      ),
    ],
  ),
)
```

### Robust

#### 4.1 Compatible
- ✅ **Parsing** robust for user agents
- ✅ **Name, role, value** for all UI components
- ✅ **Status messages** can be programmatically determined

**Semantics in Flutter:**
```dart
// Semantic widget
Semantics(
  button: true,
  enabled: _isEnabled,
  label: 'Like this post',
  value: _isLiked.toString(),
  onTap: _toggleLike,
  child: IconButton(
    icon: Icon(_isLiked ? Iconsax.heart : Iconsax.heart_copy),
    onPressed: _toggleLike,
  ),
)

// Merge semantics for complex widgets
MergeSemantics(
  child: Row(
    children: [
      Icon(Iconsax.heart),
      Text('123'),
    ],
  ),
)
```

---

## 🌈 Platform-Specific Accessibility

### iOS

#### VoiceOver
- ✅ **All interactive elements** have accessibility labels
- ✅ **Custom actions** are exposed to VoiceOver
- ✅ **Traits** correctly set (button, header, etc.)
- ✅ **Announcements** for state changes

**Flutter Implementation:**
```dart
// VoiceOver support
Semantics(
  label: 'Like button',
  hint: 'Double tap to like this post',
  button: true,
  isHeader: false,
  isEnabled: true,
  child: IconButton(
    icon: Icon(Iconsax.heart),
    onPressed: _likePost,
  ),
)

// Announce state change
void _announceToVoiceOver(String message) {
  // On iOS, use semantics service
  if (Platform.isIOS) {
    SemanticsService.announce(message, TextDirection.ltr);
  }
}
```

#### Dynamic Type
- ✅ **All text scales** with Dynamic Type
- ✅ **Layouts adapt** to text size changes
- ✅ **Minimum text size** respected

**Implementation:**
```dart
// Text that scales with Dynamic Type
Text(
  'Hello',
  style: TextStyle(
    fontSize: 16, // Will scale with user's text size preference
  ),
)

// Check current text scale
final textScale = MediaQuery.of(context).textScaleFactor;
```

#### Reduced Motion
- ✅ **Respect system preference** for reduced motion
- ✅ **Provide alternatives** for animations
- ✅ **Disable non-essential** animations

**Implementation:**
```dart
// Check for reduced motion
bool get reducedMotion => 
    MediaQuery.of(context).prefersReducedMotion;

// Usage
AnimatedContainer(
  duration: reducedMotion ? Duration.zero : MotionTokens.normal,
  curve: reducedMotion ? Curves.linear : Curves.easeOut,
  child: ...
)

// Or disable animations entirely
if (reducedMotion) {
  return widget; // No animation
}
return AnimatedWidget(...);
```

#### Dark Mode
- ✅ **Support dark mode** with appropriate colors
- ✅ **Test in dark mode**
- ✅ **Respect system preference**

### Android

#### TalkBack
- ✅ **All interactive elements** have content descriptions
- ✅ **Custom views** expose accessibility information
- ✅ **Focus management** works correctly
- ✅ **Announcements** for state changes

**Flutter Implementation:**
```dart
// TalkBack support
Semantics(
  label: 'Like button',
  child: IconButton(
    icon: Icon(Iconsax.heart),
    onPressed: _likePost,
  ),
)

// Announce to TalkBack
void _announceToTalkBack(String message) {
  if (Platform.isAndroid) {
    SemanticsService.announce(message, TextDirection.ltr);
  }
}
```

#### Accessibility Suite
- ✅ **Accessibility Scanner** testing
- ✅ **TalkBack** testing
- ✅ **Switch Access** testing

### Web

#### ARIA
- ✅ **ARIA roles** for custom widgets
- ✅ **ARIA properties** for state management
- ✅ **ARIA live regions** for dynamic content
- ✅ **Keyboard navigation** works correctly

**Flutter Web Implementation:**
```dart
// ARIA attributes
HtmlElementView(
  viewType: 'button',
  onCreateController: (controller) {
    controller.element.setAttribute('aria-label', 'Like button');
    controller.element.setAttribute('aria-pressed', _isLiked.toString());
  },
)

// Or use semantic widgets that generate ARIA automatically
Semantics(
  button: true,
  label: 'Like button',
  isEnabled: true,
  child: ...
)
```

#### Keyboard Navigation
- ✅ **Tab order** is logical
- ✅ **Focus styles** are visible
- ✅ **Keyboard shortcuts** work
- ✅ **Skip links** provided

**Keyboard Shortcuts:**
```dart
// Global keyboard shortcuts
Shortcuts(
  shortcuts: {
    // Navigation
    LogicalKeySet(LogicalKeyboardKey.arrowLeft): const MoveLeftIntent(),
    LogicalKeySet(LogicalKeyboardKey.arrowRight): const MoveRightIntent(),
    LogicalKeySet(LogicalKeyboardKey.arrowUp): const MoveUpIntent(),
    LogicalKeySet(LogicalKeyboardKey.arrowDown): const MoveDownIntent(),
    
    // Actions
    LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
    LogicalKeySet(LogicalKeyboardKey.space): const ActivateIntent(),
    LogicalKeySet(LogicalKeyboardKey.keyL): const LikeIntent(),
    LogicalKeySet(LogicalKeyboardKey.keyR): const ReplyIntent(),
    
    // Escape
    LogicalKeySet(LogicalKeyboardKey.escape): const DismissIntent(),
  },
  child: Actions(
    actions: {
      MoveLeftIntent: CallbackAction(onInvoke: (_) => _moveLeft()),
      MoveRightIntent: CallbackAction(onInvoke: (_) => _moveRight()),
      ActivateIntent: CallbackAction(onInvoke: (_) => _activate()),
      LikeIntent: CallbackAction(onInvoke: (_) => _likePost()),
      ReplyIntent: CallbackAction(onInvoke: (_) => _replyToPost()),
      DismissIntent: CallbackAction(onInvoke: (_) => _dismiss()),
    },
    child: ...
  ),
)
```

---

## 🧪 Accessibility Testing

### Automated Testing

#### Flutter Accessibility Tools
```dart
// Test semantics
void testSemantics() {
  final tester = WidgetTester();
  
  // Build widget
  await tester.pumpWidget(MyWidget());
  
  // Verify semantics
  expect(tester.getSemantics(), findsOneWidget);
  
  // Verify label
  expect(
    tester.getSemantics(find.byType(ElevatedButton)),
    matchesSemantics(
      label: 'Submit',
      isButton: true,
      isEnabled: true,
    ),
  );
  
  // Verify focus
  expect(tester.hasFocus, false);
}
```

#### Color Contrast Testing
```dart
// Test color contrast
void testColorContrast() {
  // Calculate contrast ratio
  final contrastRatio = calculateContrast(
    Colors.black.value,
    Colors.white.value,
  );
  
  // Verify minimum contrast
  expect(contrastRatio, greaterThanOrEqualTo(4.5));
}

// Contrast calculation (WCAG formula)
double calculateContrast(int foreground, int background) {
  final l1 = _relativeLuminance(foreground);
  final l2 = _relativeLuminance(background);
  
  final lighter = max(l1, l2);
  final darker = min(l1, l2);
  
  return (lighter + 0.05) / (darker + 0.05);
}

double _relativeLuminance(int color) {
  final r = _sRGBtoLinear((color >> 16) & 0xFF) / 255;
  final g = _sRGBtoLinear((color >> 8) & 0xFF) / 255;
  final b = _sRGBtoLinear(color & 0xFF) / 255;
  
  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
}

double _sRGBtoLinear(int value) {
  final v = value / 255;
  return v <= 0.03928 ? v / 12.92 : pow((v + 0.055) / 1.055, 2.4);
}
```

### Manual Testing

#### Screen Reader Testing

**iOS (VoiceOver):**
1. Enable VoiceOver: Settings > Accessibility > VoiceOver
2. Navigate through the app using swipe gestures
3. Verify all interactive elements are announced correctly
4. Verify focus order is logical
5. Test custom actions and traits

**Android (TalkBack):**
1. Enable TalkBack: Settings > Accessibility > TalkBack
2. Navigate through the app using swipe gestures
3. Verify all interactive elements are announced correctly
4. Verify focus order is logical
5. Test custom views and semantics

**Web (NVDA/JAWS):**
1. Install screen reader (NVDA, JAWS, or VoiceOver on Mac)
2. Navigate through the web app using Tab and arrow keys
3. Verify all interactive elements are announced correctly
4. Verify ARIA attributes are read correctly
5. Test keyboard navigation

#### Keyboard Testing

1. **Tab Navigation**: Tab through all interactive elements
2. **Focus Styles**: Verify focus indicators are visible
3. **Keyboard Shortcuts**: Test all keyboard shortcuts
4. **Skip Links**: Test skip to main content links
5. **Form Navigation**: Test form field navigation

#### Color Contrast Testing

1. **Automated Tools**: Use WebAIM Contrast Checker, axe, or Lighthouse
2. **Manual Inspection**: Visually inspect color combinations
3. **Grayscale Testing**: View the app in grayscale to check contrast
4. **Color Blindness Simulation**: Use tools like Color Oracle or Sim Daltonism

#### Reduced Motion Testing

1. **iOS**: Settings > Accessibility > Motion > Reduce Motion
2. **Android**: Settings > Accessibility > Remove animations
3. **Web**: System preferences or `prefers-reduced-motion` media query
4. **Verify**: All animations are disabled or simplified

#### Dynamic Type Testing

1. **iOS**: Settings > Accessibility > Display & Text Size > Larger Text
2. **Android**: Settings > Accessibility > Font Size
3. **Verify**: All text scales appropriately
4. **Verify**: Layouts adapt to text size changes

---

## 📊 Accessibility Audit Checklist

### Pre-Development
- [ ] Define accessibility requirements
- [ ] Identify target users and their needs
- [ ] Establish accessibility testing process
- [ ] Train team on accessibility fundamentals

### Design
- [ ] Color contrast meets WCAG 2.1 AA
- [ ] Text is readable and resizable
- [ ] Touch targets are at least 44×44px
- [ ] Interactive elements have clear visual indicators
- [ ] Navigation is consistent and predictable
- [ ] Form fields have clear labels
- [ ] Error messages are descriptive
- [ ] Alternative text provided for all images
- [ ] Captions provided for all audio/video

### Development
- [ ] All interactive elements are keyboard accessible
- [ ] Focus indicators are visible
- [ ] Semantic structure is correct
- [ ] ARIA attributes are properly set
- [ ] Screen reader testing completed
- [ ] Keyboard navigation testing completed
- [ ] Color contrast testing completed
- [ ] Reduced motion support implemented
- [ ] Dynamic type support implemented
- [ ] Dark mode support implemented

### Testing
- [ ] Automated accessibility tests pass
- [ ] Manual screen reader testing completed
- [ ] Manual keyboard testing completed
- [ ] Color contrast audit completed
- [ ] Reduced motion testing completed
- [ ] Dynamic type testing completed
- [ ] Cross-platform testing completed

### Deployment
- [ ] Accessibility statement published
- [ ] Contact information for accessibility issues provided
- [ ] Feedback mechanism for accessibility issues established
- [ ] Accessibility improvements tracked

---

## 📚 Accessibility Resources

### Guidelines
- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [Apple Human Interface Guidelines - Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility)
- [Android Accessibility Help](https://developer.android.com/guide/topics/ui/accessibility)
- [Material Design Accessibility](https://m3.material.io/design-usability/accessibility)

### Tools
- **Automated Testing:**
  - [axe DevTools](https://www.deque.com/axe/)
  - [Lighthouse](https://developers.google.com/web/tools/lighthouse)
  - [WAVE](https://wave.webaim.org/)
  - [Pa11y](https://pa11y.org/)

- **Manual Testing:**
  - [VoiceOver (iOS)](https://support.apple.com/guide/iphone/accessibility-features-ipha0a1a3b5d/ios)
  - [TalkBack (Android)](https://support.google.com/accessibility/android/answer/6151848)
  - [NVDA (Windows)](https://www.nvaccess.org/)
  - [JAWS (Windows)](https://www.freedomscientific.com/products/software/jaws/)

- **Color Contrast:**
  - [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
  - [Adobe Color Contrast Analyzer](https://color.adobe.com/create/color-contrast-analyzer)
  - [Color Oracle (Color Blindness Simulator)](https://colororacle.org/)

- **Flutter-Specific:**
  - [Flutter Accessibility](https://docs.flutter.dev/development/accessibility-and-localization/accessibility)
  - [Flutter Semantics](https://api.flutter.dev/flutter/widgets/Semantics-class.html)
  - [Flutter Accessibility Testing](https://flutter.github.io/semantics/)

### Communities
- [WebAIM](https://webaim.org/)
- [W3C WAI](https://www.w3.org/WAI/)
- [A11Y Project](https://www.a11yproject.com/)
- [Accessible Twitter](https://twitter.com/i/communities/1345338508381708288)

---

## 📝 Accessibility Statement Template

```markdown
# Accessibility Statement

Kyron is committed to creating an inclusive and accessible experience for all users. We strive to meet the Web Content Accessibility Guidelines (WCAG) 2.1 Level AA standards.

## Our Commitment

- We design and develop our products with accessibility in mind
- We test our products with assistive technologies
- We provide training to our team on accessibility best practices
- We continuously improve our accessibility based on user feedback

## Supported Features

### Screen Readers
- All interactive elements have descriptive labels
- Content structure is programmatically determinable
- State changes are announced to assistive technologies

### Keyboard Navigation
- All functionality is available via keyboard
- Focus indicators are visible for all interactive elements
- Logical tab order preserves meaning and operability

### Color and Contrast
- Minimum 4.5:1 contrast ratio for normal text
- Minimum 3:1 contrast ratio for large text
- Color is not the only visual means of conveying information

### Motion
- Respects system preference for reduced motion
- Provides alternatives for animated content

### Text
- Text can be resized up to 200% without loss of content or functionality
- Supports dynamic type on iOS and Android

## Known Limitations

[List any known accessibility issues and workarounds]

## Feedback

If you encounter accessibility barriers or have suggestions for improvement, please contact us:

- Email: accessibility@kyron.so
- GitHub: [KyronLabs/kyron](https://github.com/KyronLabs/kyron)

We will respond to accessibility feedback within [X] business days.

## Compliance Status

We are working towards full WCAG 2.1 Level AA compliance. Our current status:

- [ ] Perceivable
  - [ ] Text Alternatives
  - [ ] Adaptable
  - [ ] Distinguishable
- [ ] Operable
  - [ ] Keyboard Accessible
  - [ ] Enough Time
  - [ ] Seizures
  - [ ] Navigable
- [ ] Understandable
  - [ ] Readable
  - [ ] Predictable
  - [ ] Input Assistance
- [ ] Robust
  - [ ] Compatible

Last updated: [Date]
```

---

*"Accessibility is not a feature. It's a fundamental aspect of good design."*

**Accessibility Guidelines** — Version 1.0 — Kyron Design System
