import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// These files shipped for months without ever being compiled: tokens.dart
/// used Color, Radius and BorderRadius with no import, and theme.dart declared
/// `extension Radius on num`, shadowing Flutter's own Radius throughout. A
/// package that is never built is documentation wearing a .dart extension, so
/// this asserts the parts an application actually consumes.
void main() {
  group('KyronTheme', () {
    test('builds all three themes', () {
      for (final theme in [
        KyronTheme.lightTheme,
        KyronTheme.darkTheme,
        KyronTheme.dimTheme,
      ]) {
        expect(theme, isA<ThemeData>());
        expect(theme.colorScheme.surface, isA<Color>());
      }
    });

    test('light and dark are actually different', () {
      expect(
        KyronTheme.lightTheme.colorScheme.brightness,
        Brightness.light,
      );
      expect(KyronTheme.darkTheme.colorScheme.brightness, Brightness.dark);
    });

    testWidgets('a MaterialApp renders under each theme', (tester) async {
      for (final theme in [KyronTheme.lightTheme, KyronTheme.darkTheme]) {
        await tester.pumpWidget(
          MaterialApp(
            theme: theme,
            home: const Scaffold(body: Text('Kyron')),
          ),
        );
        expect(find.text('Kyron'), findsOneWidget);
      }
    });
  });

  group('tokens', () {
    test('the radius extension does not shadow Flutter Radius', () {
      // The bug that made every Radius.circular in theme.dart fail to resolve.
      expect(Radius.circular(8), isA<Radius>());
      expect(8.radius, BorderRadius.circular(8));
      expect(8.r, const Radius.circular(8));
    });

    test('spacing follows the documented scale', () {
      expect(
        [
          SpacingTokens.space2,
          SpacingTokens.space4,
          SpacingTokens.space8,
          SpacingTokens.space12,
          SpacingTokens.space16,
        ],
        [2.0, 4.0, 8.0, 12.0, 16.0],
      );
    });

    test('buttons are pills', () {
      // "All buttons are fully rounded pills" -- radius.md.
      expect(RadiusTokens.radiusFull, 999.0);
    });
  });
}
