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
  _rippleTests();
  _appBarTests();
  _surfaceTests();

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

void _rippleTests() {
  group('nothing ripples', () {
    final themes = {
      'light': KyronTheme.lightTheme,
      'dark': KyronTheme.darkTheme,
      'dim': KyronTheme.dimTheme,
    };

    themes.forEach((name, theme) {
      test('$name: the theme turns ink splashes off', () {
        // Four button themes set this and the theme itself did not, so the
        // rule held only for widgets that happened to be buttons. Every bare
        // InkWell fell through to Material 3's default, _InkSparkleFactory.
        expect(theme.splashFactory, same(NoSplash.splashFactory),
            reason: '$name still uses ${theme.splashFactory.runtimeType}');
      });

      testWidgets('$name: pressing a bare InkWell draws no ink',
          (tester) async {
        await tester.pumpWidget(MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Center(
              child: Material(
                color: const Color(0xFF808080),
                child: InkWell(
                  onTap: () {},
                  // The press highlight is a separate effect that Kyron does
                  // keep; off here so that what is left to count is the ink.
                  highlightColor: const Color(0x00000000),
                  splashColor: const Color(0xFFFF0000),
                  child: const SizedBox(width: 200, height: 80),
                ),
              ),
            ),
          ),
        ));
        await tester.pumpAndSettle();

        final press =
            await tester.startGesture(tester.getCenter(find.byType(InkWell)));
        // Part-way into a splash: wide enough to be on the canvas, not yet
        // faded back out.
        await tester.pump(const Duration(milliseconds: 200));

        // Measured against every factory Flutter ships. With ink off the
        // Material draws its own background and nothing else: one rect, no
        // circle. InkSplash and InkRipple add a circle; InkSparkle -- the
        // Material 3 default these themes used to fall through to -- draws
        // through a shader, so it shows up as a second rect rather than a
        // circle and a circle check alone would not have caught it.
        final material = Material.of(tester.element(find.byType(InkWell)));
        expect(material, paintsExactlyCountTimes(#drawRect, 1),
            reason: '$name drew ink on press');
        expect(material, paintsExactlyCountTimes(#drawCircle, 0),
            reason: '$name rippled on press');

        await press.up();
        await tester.pumpAndSettle();
      });
    });
  });
}

/// An app bar stays the colour it is when the page moves under it.
///
/// `elevation: 0` does not say this. Material 3 keeps a second elevation for
/// the scrolled-under state and washes the bar with `surfaceTint` at any
/// elevation above zero -- so the bars went faintly blue the moment a list
/// moved, and only then. That is the sort of thing nothing catches, because
/// every screenshot is taken at the top of the page.
void _appBarTests() {
  group('the app bar under a scrolling page', () {
    for (final (name, theme) in [
      ('light', KyronTheme.lightTheme),
      ('dark', KyronTheme.darkTheme),
      ('dim', KyronTheme.dimTheme),
    ]) {
      testWidgets('$name does not tint', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: theme,
            home: Scaffold(
              appBar: AppBar(title: const Text('Kyron')),
              body: ListView.builder(
                itemCount: 60,
                itemBuilder: (_, i) => SizedBox(height: 56, child: Text('$i')),
              ),
            ),
          ),
        );

        Material barMaterial() => tester.widget<Material>(
              find
                  .descendant(
                    of: find.byType(AppBar),
                    matching: find.byType(Material),
                  )
                  .first,
            );

        final atRest = barMaterial().color;
        expect(barMaterial().elevation, 0, reason: '$name was raised at rest');

        // Far enough that the first rows are well past the bar.
        await tester.drag(find.byType(ListView), const Offset(0, -400));
        await tester.pumpAndSettle();

        final scrolled = barMaterial();
        expect(scrolled.elevation, 0,
            reason: '$name raised the bar once the page scrolled under it, '
                'which is what draws the tint');
        expect(scrolled.surfaceTintColor, Colors.transparent,
            reason: '$name left a surface tint on the bar');
        expect(scrolled.color, atRest,
            reason: '$name changed the bar colour on scroll');
      });
    }
  });
}

/// A thing drawn on a surface is not the colour of that surface.
///
/// Material 3 has four container roles, and Flutter falls every one of them
/// back to `surface` when a ColorScheme is built without them. This file did
/// that, so every container in Kyron was drawn in exactly the colour of the
/// page behind it -- 1.00:1. The interest chips, the other person's chat
/// bubbles and the post analytics tiles were all invisible; their borders and
/// their text were the only reason anybody could tell where they were.
///
/// The steps are meant to be quiet, so this asks for a floor rather than a
/// ratio: enough to be seen, and each one above the last.
void _surfaceTests() {
  /// WCAG relative luminance.
  double luminance(Color c) {
    double channel(double v) => v <= 0.03928
        ? v / 12.92
        : math.pow((v + 0.055) / 1.055, 2.4).toDouble();
    return 0.2126 * channel(c.r) +
        0.7152 * channel(c.g) +
        0.0722 * channel(c.b);
  }

  double contrast(Color a, Color b) {
    final first = luminance(a), second = luminance(b);
    return first > second
        ? (first + 0.05) / (second + 0.05)
        : (second + 0.05) / (first + 0.05);
  }

  group('surfaces', () {
    for (final (name, theme) in [
      ('light', KyronTheme.lightTheme),
      ('dark', KyronTheme.darkTheme),
      ('dim', KyronTheme.dimTheme),
    ]) {
      test('$name tells a container apart from the page under it', () {
        final scheme = theme.colorScheme;
        final roles = {
          'surfaceContainerLow': scheme.surfaceContainerLow,
          'surfaceContainer': scheme.surfaceContainer,
          'surfaceContainerHigh': scheme.surfaceContainerHigh,
          'surfaceContainerHighest': scheme.surfaceContainerHighest,
          'primaryContainer': scheme.primaryContainer,
        };

        for (final entry in roles.entries) {
          expect(
            contrast(entry.value, scheme.surface),
            greaterThan(1.02),
            reason: '$name: ${entry.key} is the colour of the surface it is '
                'drawn on, so anything using it is invisible',
          );
        }
      });

      test('$name steps up, rather than in circles', () {
        final scheme = theme.colorScheme;
        // Each step further from the surface than the one below it, which is
        // what makes "high" and "highest" mean anything.
        final ladder = [
          scheme.surface,
          scheme.surfaceContainerLow,
          scheme.surfaceContainer,
          scheme.surfaceContainerHigh,
          scheme.surfaceContainerHighest,
        ];
        for (var i = 1; i < ladder.length; i++) {
          expect(
            contrast(ladder[i], scheme.surface),
            greaterThan(contrast(ladder[i - 1], scheme.surface)),
            reason: '$name: step $i is no further from the surface than the '
                'step below it',
          );
        }
      });
    }
  });
}
