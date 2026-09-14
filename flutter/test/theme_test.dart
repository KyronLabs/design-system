import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// These files shipped for months without ever being compiled: tokens.dart
/// used Color, Radius and BorderRadius with no import, and theme.dart declared
/// `extension Radius on num`, shadowing Flutter's own Radius throughout. A
/// package that is never built is documentation wearing a .dart extension, so
/// this asserts the parts an application actually consumes.
void main() {
  _contrastTests();

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

    test('every text field is the same height', () {
      // Padding alone does not settle this: a field carrying 16pt text is
      // taller than one carrying 14pt for the same padding, which is how the
      // search box became the only one that looked right. A floor on the box
      // settles it whatever text a screen puts in it.
      for (final theme in [
        KyronTheme.lightTheme,
        KyronTheme.darkTheme,
        KyronTheme.dimTheme,
      ]) {
        expect(
          theme.inputDecorationTheme.constraints?.minHeight,
          KyronTheme.fieldHeight,
        );
      }
    });

    test('a field is a comfortable tap target', () {
      // Both Material and Apple land on 44 for something you press.
      expect(KyronTheme.fieldHeight, greaterThanOrEqualTo(44));
    });

    test('buttons are pills', () {
      // "All buttons are fully rounded pills" -- radius.md.
      expect(RadiusTokens.radiusFull, 999.0);
    });

    test('an app bar title is set in Kyron\'s type', () {
      // `textTheme` gets the family from `.apply(fontFamily:)`, but an
      // AppBar's `titleTextStyle` does not merge into the text theme -- it
      // *becomes* the DefaultTextStyle for the title. A style written here
      // without a family silently drops it, and every AppBar title in every
      // app using this theme is then drawn in whatever the platform hands
      // back. It looked right on Android, where that happens to be Roboto.
      for (final theme in [
        KyronTheme.lightTheme,
        KyronTheme.darkTheme,
        KyronTheme.dimTheme,
      ]) {
        expect(
          theme.appBarTheme.titleTextStyle?.fontFamily,
          theme.textTheme.bodyMedium?.fontFamily,
          reason: 'the bar and the body disagree about the type family',
        );
        expect(theme.appBarTheme.titleTextStyle?.fontFamily, isNotNull);
      }
    });
  });
}

/// Relative luminance, per WCAG 2.1.
double _luminance(Color c) {
  double channel(double v) =>
      v <= 0.03928 ? v / 12.92 : math.pow((v + 0.055) / 1.055, 2.4).toDouble();
  return 0.2126 * channel(c.r) + 0.7152 * channel(c.g) + 0.0722 * channel(c.b);
}

/// The WCAG contrast ratio between two opaque colours, 1.0 to 21.0.
double _contrast(Color a, Color b) {
  final la = _luminance(a);
  final lb = _luminance(b);
  final (hi, lo) = la > lb ? (la, lb) : (lb, la);
  return (hi + 0.05) / (lo + 0.05);
}

void _contrastTests() {
  group('every theme is legible', () {
    final themes = {
      'light': KyronTheme.lightTheme,
      'dark': KyronTheme.darkTheme,
      'dim': KyronTheme.dimTheme,
    };

    themes.forEach((name, theme) {
      test('$name: the floating action button can be seen', () {
        // This is not hypothetical. Material 3 draws a FAB in
        // `primaryContainer` on `onPrimaryContainer`; this file set the
        // first and left the second unset, which resolves to pure white --
        // so the light theme shipped a white glyph on a #F7F7F7 disc, at
        // 1.06:1. It was reported as "a white icon on a white background".
        final fab = theme.floatingActionButtonTheme;
        expect(fab.backgroundColor, isNotNull, reason: '$name has no FAB bg');
        expect(fab.foregroundColor, isNotNull, reason: '$name has no FAB fg');

        final ratio = _contrast(fab.backgroundColor!, fab.foregroundColor!);
        // 3:1 is WCAG AA for a graphical object, which an icon is.
        expect(ratio, greaterThanOrEqualTo(3.0),
            reason: '$name FAB is ${ratio.toStringAsFixed(2)}:1');
      });

      test('$name: the accent is the documented token', () {
        // The ramp's 500 step is labelled DEFAULT ACCENT and was referenced
        // nowhere; a second literal, #4C8FFF, sat beside it and every one of
        // the twenty-six accent-coloured controls took that one instead. So
        // the design system documented #006AFF and shipped something else.
        expect(KyronTheme.accent, KyronTheme.primary[500]);
        expect(KyronTheme.accent, const Color(0xFF006AFF));
        expect(theme.colorScheme.primary, KyronTheme.accent);
        expect(theme.colorScheme.secondary, KyronTheme.accent);
      });

      test('$name: accent-on-white is readable', () {
        // 4.66:1 for the documented token against 3.14:1 for what shipped --
        // the difference between passing WCAG AA for text and not.
        expect(_contrast(KyronTheme.accent, const Color(0xFFFFFFFF)),
            greaterThanOrEqualTo(4.5));
      });

      test('$name: a container states its own foreground', () {
        // An unset `on*` does not get derived; it comes back white. Setting
        // one half of a pair is how this went wrong once already.
        final s = theme.colorScheme;
        final ratio = _contrast(s.primaryContainer, s.onPrimaryContainer);
        expect(ratio, greaterThanOrEqualTo(4.5),
            reason: '$name primaryContainer pair is '
                '${ratio.toStringAsFixed(2)}:1');
      });
    });
  });
}
