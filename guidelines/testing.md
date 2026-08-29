# Testing & Quality Standards

## 🧪 Testing Philosophy

Kyron's testing standards ensure **reliability, performance, and quality** across all platforms. We test at multiple levels — from individual components to end-to-end user flows — with a focus on **automation** and **developer productivity**.

### Core Principles

1. **Test Pyramid**: Many unit tests, some integration tests, few E2E tests
2. **Automation First**: Automate everything that can be automated
3. **Fast Feedback**: Tests should run quickly to enable rapid iteration
4. **Comprehensive Coverage**: Test all critical paths and edge cases
5. **Platform Parity**: Test on iOS, Android, and Web
6. **Accessibility**: Test with assistive technologies
7. **Performance**: Test performance characteristics

---

## 📊 Test Pyramid

```
        ┌─────────────┐
        │   E2E Tests  │  ← Few (10-20)
        │   (Playwright)│
        └──────┬──────┘
               │
        ┌──────▼──────┐
        │Integration   │  ← Some (50-100)
        │   Tests      │
        └──────┬──────┘
               │
        ┌──────▼──────┐
        │  Unit Tests  │  ← Many (500+)
        │  (Dart)      │
        └─────────────┘
```

### Test Distribution Goals

| Level | Count | Coverage | Runtime | Responsibility |
|-------|-------|----------|---------|----------------|
| Unit | 500+ | 80%+ | <10s | Developers |
| Integration | 50-100 | Key flows | <60s | Developers |
| E2E | 10-20 | Critical paths | <5min | QA/Developers |

---

## 🔧 Unit Testing

### Flutter Widget Tests

**Framework**: `flutter_test` package

**Best Practices:**
- Test widget rendering
- Test widget interactions
- Test state changes
- Test edge cases
- Mock dependencies

**Example:**

```dart
// Widget test for PostCard
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron/widgets/post_card.dart';

void main() {
  testWidgets('PostCard renders correctly', (WidgetTester tester) async {
    // Build widget
    await tester.pumpWidget(
      MaterialApp(
        home: PostCard(
          post: testPost,
          onTap: () {},
          onDoubleTap: () {},
          onLongPress: () {},
        ),
      ),
    );
    
    // Verify rendering
    expect(find.text(testPost.content), findsOneWidget);
    expect(find.byIcon(Iconsax.heart_copy), findsOneWidget);
    expect(find.byIcon(Iconsax.chat), findsOneWidget);
    
    // Verify semantics
    expect(
      tester.getSemantics(find.byType(PostCard)),
      matchesSemantics(
        isHeader: false,
        isButton: true,
      ),
    );
  });
  
  testWidgets('PostCard tap calls onTap', (WidgetTester tester) async {
    bool tapped = false;
    
    await tester.pumpWidget(
      MaterialApp(
        home: PostCard(
          post: testPost,
          onTap: () => tapped = true,
          onDoubleTap: () {},
          onLongPress: () {},
        ),
      ),
    );
    
    // Tap the card
    await tester.tap(find.byType(PostCard));
    await tester.pump();
    
    // Verify callback
    expect(tapped, true);
  });
  
  testWidgets('PostCard double tap calls onDoubleTap', (WidgetTester tester) async {
    bool doubleTapped = false;
    
    await tester.pumpWidget(
      MaterialApp(
        home: PostCard(
          post: testPost,
          onTap: () {},
          onDoubleTap: () => doubleTapped = true,
          onLongPress: () {},
        ),
      ),
    );
    
    // Double tap the card
    await tester.tap(find.byType(PostCard));
    await tester.pump();
    await tester.tap(find.byType(PostCard));
    await tester.pump();
    
    // Verify callback
    expect(doubleTapped, true);
  });
}
```

### Dart Unit Tests

**Framework**: `test` package

**Best Practices:**
- Test pure functions
- Test business logic
- Test state management
- Mock external dependencies

**Example:**

```dart
// Test for thread layout logic
import 'package:test/test.dart';
import 'package:kyron/models/thread_model.dart';

void main() {
  group('ThreadLayout', () {
    test('builds correct layout for simple thread', () {
      final posts = [
        Post(id: '1', parentId: null, depth: 0),
        Post(id: '2', parentId: '1', depth: 1),
        Post(id: '3', parentId: '2', depth: 2),
      ];
      
      final layout = buildThreadLayout(posts);
      
      expect(layout.length, 3);
      expect(layout[0].depth, 0);
      expect(layout[1].depth, 1);
      expect(layout[2].depth, 2);
    });
    
    test('handles multiple root posts', () {
      final posts = [
        Post(id: '1', parentId: null, depth: 0),
        Post(id: '2', parentId: null, depth: 0),
        Post(id: '3', parentId: '1', depth: 1),
      ];
      
      final layout = buildThreadLayout(posts);
      
      expect(layout.length, 3);
      expect(layout[0].depth, 0);
      expect(layout[1].depth, 0);
      expect(layout[2].depth, 1);
    });
    
    test('respects max depth', () {
      final posts = List.generate(10, (i) => 
        Post(id: i.toString(), parentId: i > 0 ? (i-1).toString() : null, depth: i)
      );
      
      final layout = buildThreadLayout(posts);
      
      // All posts should be in layout, but depth capped
      expect(layout.length, 10);
      expect(layout.last.depth, lessThanOrEqualTo(ThreadTokens.maxIndent));
    });
  });
}
```

### Mocking Dependencies

**Framework**: `mockito` package

**Example:**

```dart
// Mock API client
import 'package:mockito/mockito.dart';
import 'package:kyron/services/api_client.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  test('fetchPosts returns posts', () async {
    final api = MockApiClient();
    final posts = [Post(id: '1'), Post(id: '2')];
    
    when(api.fetchPosts()).thenAnswer((_) async => posts);
    
    final result = await api.fetchPosts();
    
    expect(result, posts);
    verify(api.fetchPosts()).called(1);
  });
  
  test('fetchPosts handles errors', () async {
    final api = MockApiClient();
    
    when(api.fetchPosts()).thenThrow(Exception('Failed to fetch'));
    
    expect(() => api.fetchPosts(), throwsException);
  });
}
```

---

## 🔗 Integration Testing

### Flutter Integration Tests

**Framework**: `integration_test` package

**Best Practices:**
- Test user flows across multiple screens
- Test navigation
- Test state persistence
- Test platform-specific behavior

**Example:**

```dart
// Integration test for authentication flow
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('Authentication Flow', () {
    testWidgets('can login and see home screen', (WidgetTester tester) async {
      // Build app
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();
      
      // Verify on login screen
      expect(find.text('Log In'), findsOneWidget);
      
      // Enter credentials
      await tester.enterText(find.bySemanticsLabel('Email'), 'test@example.com');
      await tester.enterText(find.bySemanticsLabel('Password'), 'password123');
      await tester.pump();
      
      // Tap login button
      await tester.tap(find.text('Log In'));
      await tester.pumpAndSettle();
      
      // Verify on home screen
      expect(find.text('Home'), findsOneWidget);
    });
    
    testWidgets('shows error for invalid credentials', (WidgetTester tester) async {
      // Build app
      await tester.pumpWidget(MyApp());
      await tester.pumpAndSettle();
      
      // Enter invalid credentials
      await tester.enterText(find.bySemanticsLabel('Email'), 'invalid@example.com');
      await tester.enterText(find.bySemanticsLabel('Password'), 'wrong');
      await tester.pump();
      
      // Tap login button
      await tester.tap(find.text('Log In'));
      await tester.pumpAndSettle();
      
      // Verify error message
      expect(find.text('Invalid credentials'), findsOneWidget);
    });
  });
}
```

---

## 🌐 E2E Testing

### Web E2E Testing with Playwright

**Framework**: Playwright

**Configuration:**
```javascript
// playwright.config.js
module.exports = {
  testDir: './tests',
  timeout: 30000,
  retries: 1,
  use: {
    baseURL: 'http://localhost:3000',
    headless: true,
    viewport: { width: 1280, height: 720 },
    video: 'retain-on-failure',
    screenshot: 'only-on-failure',
  },
  projects: [
    { name: 'chromium', use: { browserName: 'chromium' } },
    { name: 'firefox', use: { browserName: 'firefox' } },
    { name: 'webkit', use: { browserName: 'webkit' } },
  ],
};
```

**Example Test:**
```javascript
// tests/authentication.spec.js
const { test, expect } = require('@playwright/test');

test.describe('Authentication', () => {
  test('can login with valid credentials', async ({ page }) => {
    // Navigate to login page
    await page.goto('/login');
    
    // Fill in credentials
    await page.fill('input[type="email"]', 'test@example.com');
    await page.fill('input[type="password"]', 'password123');
    
    // Click login button
    await page.click('button[type="submit"]');
    
    // Wait for navigation
    await page.waitForURL('/home');
    
    // Verify on home page
    await expect(page).toHaveURL('/home');
    await expect(page.locator('h1')).toHaveText('Home');
  });
  
  test('shows error for invalid credentials', async ({ page }) => {
    // Navigate to login page
    await page.goto('/login');
    
    // Fill in invalid credentials
    await page.fill('input[type="email"]', 'invalid@example.com');
    await page.fill('input[type="password"]', 'wrong');
    
    // Click login button
    await page.click('button[type="submit"]');
    
    // Verify error message
    await expect(page.locator('.error')).toHaveText('Invalid credentials');
  });
});
```

### Mobile E2E Testing

**Framework**: Flutter Driver (for Flutter apps)

**Example:**
```dart
// Integration test for mobile app
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron/main.dart';

void main() {
  // Enable Flutter Driver
  enableFlutterDriverExtension();
  
  group('Mobile App', () {
    FlutterDriver driver;
    
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
    
    tearDownAll(() async {
      if (driver != null) {
        await driver.close();
      }
    });
    
    test('can create post', () async {
      // Find and tap create button
      final createButton = find.byTooltip('Create Post');
      await driver.tap(createButton);
      
      // Wait for composer
      await driver.waitFor(find.byType('ComposerScreen'));
      
      // Enter text
      await driver.tap(find.byType('TextField'));
      await driver.enterText('Hello World');
      
      // Tap post button
      await driver.tap(find.text('Post'));
      
      // Wait for feed
      await driver.waitFor(find.text('Hello World'));
    });
  });
}
```

---

## 📈 Performance Testing

### Flutter Performance Testing

**Framework**: `flutter_test` with performance overlay

**Best Practices:**
- Test frame times (should be <16ms for 60fps)
- Test widget build times
- Test image loading performance
- Test list scrolling performance

**Example:**

```dart
// Performance test for feed scrolling
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron/screens/feed_screen.dart';

void main() {
  testWidgets('Feed scrolls at 60fps', (WidgetTester tester) async {
    // Build feed with many posts
    final posts = List.generate(100, (i) => Post(id: i.toString()));
    
    await tester.pumpWidget(
      MaterialApp(
        home: FeedScreen(posts: posts),
      ),
    );
    
    // Enable performance overlay
    await tester.pumpWidget(
      MaterialApp(
        home: FeedScreen(posts: posts),
        debugShowCheckedModeBanner: false,
      ),
      surface: true,
    );
    
    // Scroll through feed
    final listFinder = find.byType(ListView);
    await tester.drag(listFinder, Offset(0, -500));
    await tester.pump();
    
    // Check frame times
    final frameTimes = tester.binding.window.physicalSizeToLogicalSize(
      tester.binding.window.devicePixelRatio,
    );
    
    // Verify average frame time < 16ms
    // (This is a simplified example - actual frame time measurement
    // would require more sophisticated instrumentation)
  });
}
```

### Web Performance Testing

**Framework**: Lighthouse, WebPageTest

**Metrics to Track:**
- **First Contentful Paint (FCP)**: <1.8s
- **Largest Contentful Paint (LCP)**: <2.5s
- **First Input Delay (FID)**: <100ms
- **Cumulative Layout Shift (CLS)**: <0.1
- **Time to Interactive (TTI)**: <3.8s

**Example Lighthouse Test:**
```bash
# Run Lighthouse audit
lighthouse http://localhost:3000 --output=json --output-path=./lighthouse.json

# Run with specific categories
lighthouse http://localhost:3000 --chrome-flags="--headless" --categories=performance,accessibility
```

---

## 🎯 Test Coverage

### Coverage Goals

| Area | Target Coverage | Measurement |
|------|-----------------|-------------|
| Unit Tests | 80%+ | Line coverage |
| Integration Tests | Key flows | Manual + automated |
| E2E Tests | Critical paths | Manual + automated |
| UI Tests | All screens | Widget tests |
| Accessibility | WCAG 2.1 AA | Manual + automated |
| Performance | 60fps | Automated |

### Coverage Reporting

**Flutter:**
```bash
# Run tests with coverage
flutter test --coverage

# Generate coverage report
genhtml coverage/lcov.info -o coverage/html

# Open report
open coverage/html/index.html
```

**Dart:**
```bash
# Run tests with coverage
dart test --coverage=coverage

# Generate coverage report
dart pub global run coverage:format_coverage --lcov -i coverage -o coverage/lcov.info
```

---

## 📱 Platform-Specific Testing

### iOS Testing

**Requirements:**
- Xcode
- iOS Simulator
- Physical devices for final testing

**Test Types:**
- Unit tests (Dart)
- Widget tests (Flutter)
- Integration tests (Flutter Driver)
- UI tests (Xcode UI Testing)
- Manual testing

**Example Xcode UI Test:**
```swift
// UITests/AuthenticationUITests.swift
import XCTest

class AuthenticationUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testLogin() {
        // Find email field
        let emailField = app.textFields["Email"]
        XCTAssertTrue(emailField.exists)
        
        // Enter email
        emailField.tap()
        emailField.typeText("test@example.com")
        
        // Find password field
        let passwordField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordField.exists)
        
        // Enter password
        passwordField.tap()
        passwordField.typeText("password123")
        
        // Tap login button
        app.buttons["Log In"].tap()
        
        // Verify on home screen
        XCTAssertTrue(app.navigationBars["Home"].exists)
    }
}
```

### Android Testing

**Requirements:**
- Android Studio
- Android Emulator
- Physical devices for final testing

**Test Types:**
- Unit tests (Dart)
- Widget tests (Flutter)
- Integration tests (Flutter Driver)
- Instrumentation tests (Android)
- Manual testing

**Example Espresso Test:**
```kotlin
// androidTest/java/com/kyron/AuthenticationTest.kt
package com.kyron

import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.action.ViewActions.click
import androidx.test.espresso.action.ViewActions.typeText
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.matcher.ViewMatchers.withId
import androidx.test.espresso.matcher.ViewMatchers.withText
import androidx.test.ext.junit.rules.ActivityScenarioRule
import androidx.test.ext.junit.runners.AndroidJUnit4
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class AuthenticationTest {
    @get:Rule
    val activityRule = ActivityScenarioRule(MainActivity::class.java)
    
    @Test
    fun testLogin() {
        // Find and enter email
        onView(withId(R.id.emailField)).perform(typeText("test@example.com"))
        
        // Find and enter password
        onView(withId(R.id.passwordField)).perform(typeText("password123"))
        
        // Click login button
        onView(withId(R.id.loginButton)).perform(click())
        
        // Verify on home screen
        onView(withText("Home")).check(matches(isDisplayed()))
    }
}
```

### Web Testing

**Requirements:**
- Modern browsers (Chrome, Firefox, Safari, Edge)
- Playwright or Selenium
- Lighthouse

**Test Types:**
- Unit tests (Dart)
- Widget tests (Flutter)
- E2E tests (Playwright)
- Performance tests (Lighthouse)
- Accessibility tests (axe, Lighthouse)
- Manual testing

---

## 🧪 Continuous Integration

### GitHub Actions Workflow

```yaml
# .github/workflows/test.yml
name: Test

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.19.0'
      
      - name: Get dependencies
        run: flutter pub get
      
      - name: Run unit tests
        run: flutter test --coverage
      
      - name: Run widget tests
        run: flutter test --coverage
      
      - name: Generate coverage report
        run: |
          genhtml coverage/lcov.info -o coverage/html
          mkdir -p coverage/artifacts
          cp -r coverage/html/* coverage/artifacts/
      
      - name: Upload coverage
        uses: actions/upload-artifact@v3
        with:
          name: coverage-report
          path: coverage/artifacts
      
      - name: Upload to Codecov
        uses: codecov/codecov-action@v3
        with:
          file: coverage/lcov.info

  integration-test:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.19.0'
      
      - name: Get dependencies
        run: flutter pub get
      
      - name: Run integration tests
        run: flutter test integration_test

  web-test:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '20'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run Playwright tests
        run: npx playwright test
      
      - name: Upload test results
        uses: actions/upload-artifact@v3
        if: always()
        with:
          name: playwright-report
          path: playwright-report/
```

---

## 📊 Quality Metrics

### Code Quality

| Metric | Target | Tool |
|--------|--------|------|
| Test Coverage | 80%+ | flutter test --coverage |
| Code Coverage | 80%+ | dart test --coverage |
| Cyclomatic Complexity | <10 | dart_analyzer |
| Maintainability Index | >50 | codeclimate |
| Technical Debt | <5% | sonarqube |

### Performance Metrics

| Metric | Target | Tool |
|--------|--------|------|
| Frame Rate | 60fps | Flutter Performance Overlay |
| App Launch Time | <2s | Flutter Driver |
| Screen Load Time | <500ms | Custom instrumentation |
| Memory Usage | <200MB | Flutter DevTools |
| CPU Usage | <50% | Flutter DevTools |

### Accessibility Metrics

| Metric | Target | Tool |
|--------|--------|------|
| WCAG 2.1 AA | 100% | axe, Lighthouse |
| Color Contrast | 4.5:1 minimum | WebAIM Contrast Checker |
| Keyboard Navigation | 100% | Manual testing |
| Screen Reader | 100% | VoiceOver, TalkBack |

### User Metrics

| Metric | Target | Tool |
|--------|--------|------|
| Crash-Free Rate | >99.9% | Crashlytics, Sentry |
| App Store Rating | >4.0 | App Store Connect |
| User Retention (D1) | >40% | Analytics |
| Session Length | >5min | Analytics |

---

## 📚 Testing Resources

### Flutter Testing
- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [Widget Testing](https://docs.flutter.dev/testing/widget)
- [Integration Testing](https://docs.flutter.dev/testing/integration)
- [Flutter Driver](https://api.flutter.dev/flutter_driver/flutter_driver-library.html)

### Dart Testing
- [Dart Testing Documentation](https://dart.dev/guides/testing)
- [test package](https://pub.dev/packages/test)
- [mockito package](https://pub.dev/packages/mockito)

### Web Testing
- [Playwright](https://playwright.dev/)
- [Lighthouse](https://developer.chrome.com/docs/lighthouse/overview/)
- [Selenium](https://www.selenium.dev/)
- [Cypress](https://www.cypress.io/)

### Mobile Testing
- [Xcode UI Testing](https://developer.apple.com/documentation/xctest)
- [Android Espresso](https://developer.android.com/training/testing/espresso)
- [Flutter Driver](https://api.flutter.dev/flutter_driver/flutter_driver-library.html)

### Performance Testing
- [Flutter Performance](https://docs.flutter.dev/perf)
- [Lighthouse](https://developer.chrome.com/docs/lighthouse/overview/)
- [WebPageTest](https://www.webpagetest.org/)

### Accessibility Testing
- [axe DevTools](https://www.deque.com/axe/)
- [Lighthouse Accessibility](https://developer.chrome.com/docs/lighthouse/accessibility/)
- [WAVE](https://wave.webaim.org/)
- [Pa11y](https://pa11y.org/)

---

## 📝 Testing Checklist

### Pre-Commit
- [ ] All new code has corresponding tests
- [ ] All tests pass locally
- [ ] Code follows style guide
- [ ] No breaking changes to existing functionality

### Pre-Merge
- [ ] All CI tests pass
- [ ] Code coverage meets targets
- [ ] Performance tests pass
- [ ] Accessibility audit completed
- [ ] Manual testing on all platforms

### Pre-Release
- [ ] Full test suite passes
- [ ] Performance metrics meet targets
- [ ] Accessibility audit completed
- [ ] Manual testing on all platforms
- [ ] Beta testing completed
- [ ] Release notes prepared

---

*"Quality is not an act, it is a habit."*

**Testing & Quality Standards** — Version 1.0 — Kyron Design System
