// Kyron Design System - Flutter Theme Implementation
// Based on Bluesky ALF (Application Layout Framework)

import 'package:flutter/material.dart';

/// Main theme class for Kyron design system
class KyronTheme {
  // ===========================================================================
  // COLOR SYSTEM
  // ===========================================================================

  /// Color Ramps from Bluesky ALF
  /// Each ramp has 13 steps (0-1000) with inversion for dark themes

  // Contrast Ramp (backgrounds, text, borders)
  static const contrast = {
    0: Color(0xFFFFFFFF), // Lightest (light bg)
    50: Color(0xFFF7F7F7),
    100: Color(0xFFE8E8E8), // Hairline dividers
    200: Color(0xFFD9D9D9), // Stronger borders
    300: Color(0xFFC9C9C9), // Input borders
    400: Color(0xFFB0B0B0), // Tertiary text, timestamps
    500: Color(0xFF999999), // Secondary text
    600: Color(0xFF737373),
    700: Color(0xFF5C5C5C), // Body text
    800: Color(0xFF3A3A3A),
    900: Color(0xFF262626),
    1000: Color(0xFF000000), // Darkest (light text)
  };

  // Primary Ramp (accent colors)
  static const primary = {
    0: Color(0xFFE6F0FF),
    50: Color(0xFFCCE0FF),
    100: Color(0xFFB3D1FF),
    200: Color(0xFF99C2FF), // Disabled state
    300: Color(0xFF80B3FF),
    400: Color(0xFF66A4FF), // Hover state (dark theme)
    500: primary500, // DEFAULT ACCENT
    600: Color(0xFF005BCC), // Pressed state (light theme)
    700: Color(0xFF004D99), // Disabled state (dark theme)
    800: Color(0xFF003F80),
    900: Color(0xFF003366),
    1000: Color(0xFF00264D),
  };

  // Positive Ramp (success states)
  static const positive = {
    0: Color(0xFFE6FFF0),
    50: Color(0xFFCCFFE0),
    100: Color(0xFFB3FFD1),
    200: Color(0xFF99FFC2),
    300: Color(0xFF80FFB3),
    400: Color(0xFF66FFA4),
    500: Color(0xFF4CD4B0), // successAqua
    600: Color(0xFF42B896),
    700: Color(0xFF389C7C),
    800: Color(0xFF2E8062),
    900: Color(0xFF246449),
    1000: Color(0xFF1A4830),
  };

  // Negative Ramp (error states)
  static const negative = {
    0: Color(0xFFFFE6E6),
    50: Color(0xFFFFCCCC),
    100: Color(0xFFFFB3B3),
    200: Color(0xFFFF9999),
    300: Color(0xFFFF8080),
    400: Color(0xFFFF6666),
    500: Color(0xFFFF4C4C),
    600: Color(0xFFFF6582), // errorPink
    700: Color(0xFFCC3D3D),
    800: Color(0xFF992E2E),
    900: Color(0xFF661F1F),
    1000: Color(0xFF331010),
  };

  // ===========================================================================
  // DIM THEME COLORS (Subdued palette)
  // ===========================================================================

  static const dimContrast = {
    0: Color(0xFF151D28), // Background
    50: Color(0xFF1E2A38),
    100: Color(0xFF2A3848), // Hairline dividers
    200: Color(0xFF384858),
    300: Color(0xFF485868),
    400: Color(0xFF607080), // Tertiary text
    500: Color(0xFF788898),
    600: Color(0xFF90A0B0),
    700: Color(0xFFA8B8C8), // Body text
    800: Color(0xFFC0D0D8),
    900: Color(0xFFD8E8F0),
    1000: Color(0xFFF0F8FF), // Primary text
  };

  // ===========================================================================
  // SEMANTIC COLORS
  // ===========================================================================

  // Light Theme Colors
  static const lightBackground = Color(0xFFFFFFFF);
  static const lightBackgroundStart = Color(0xFFFFFFFF);
  static const lightBackgroundEnd = Color(0xFFF0F4F8);
  static const lightSurface = Color(0xFFF8FAFC);

  /// What sits *on* a surface: a chip, a chat bubble, a tile.
  ///
  /// Material 3 has four of these roles and Flutter falls every one of them
  /// back to `surface` when a ColorScheme is built without them -- which is
  /// what this file did, so every container in Kyron was drawn in exactly the
  /// colour of the page behind it, measured at 1.00:1. The interest chips,
  /// the other person's chat bubbles and the post analytics tiles were all
  /// invisible; only their borders and their text gave them away.
  ///
  /// The steps are slate, the family lightSurface already belongs to, and
  /// they are deliberately quiet: 1.03, 1.05, 1.11 and 1.18 against the
  /// surface. A container is meant to be found, not announced.
  static const lightSurfaceLow = Color(0xFFF4F7FA);
  static const lightSurfaceContainer = Color(0xFFF1F5F9);
  static const lightSurfaceHigh = Color(0xFFEAEFF5);
  static const lightSurfaceHighest = Color(0xFFE2E8F0);
  static const lightTextPrimary = Color(0xFF1A202C);
  static const lightTextSecondary = Color(0xFF718096);

  // Dark Theme Colors
  static const darkBackground = Color(0xFF0D0D0F);
  static const darkSurface = Color(0xFF1A1A1D);

  /// The same four steps on the dark surface: 1.06, 1.11, 1.17 and 1.25.
  /// The first is darkPillBg, which already existed for exactly this job.
  static const darkSurfaceLow = Color(0xFF1F1F23);
  static const darkSurfaceContainer = Color(0xFF232327);
  static const darkSurfaceHigh = Color(0xFF27272C);
  static const darkSurfaceHighest = Color(0xFF2C2C33);

  /// And on dim, which is blue-grey rather than neutral: 1.08, 1.18, 1.27
  /// and 1.34.
  static const dimSurface = Color(0xFF1E2A38);
  static const dimSurfaceLow = Color(0xFF22303F);
  static const dimSurfaceContainer = Color(0xFF273647);
  static const dimSurfaceHigh = Color(0xFF2B3B4D);
  static const dimSurfaceHighest = Color(0xFF2F4053);
  static const darkTextPrimary = Color(0xFFE5EBF5);
  static const darkTextSecondary = Color(0xFF7E8A9A);

  // Shared Colors

  /// The one definition of Kyron's accent. `primary[500]` is this, and so is
  /// [accent]: a map lookup is not a constant expression, so the two cannot
  /// simply reference each other, and a second literal is how they drifted.
  static const primary500 = Color(0xFF006AFF);

  /// The accent, which is `primary[500]` and always was.
  ///
  /// It used to be a second colour written out longhand -- `0xFF4C8FFF` --
  /// sitting beside a ramp whose 500 step is labelled DEFAULT ACCENT and was
  /// referenced nowhere. Twenty-six controls took the longhand one, so every
  /// accent pixel in Kyron was a colour the design system does not document,
  /// and `design-tokens/colors.md` named `#006AFF` throughout.
  ///
  /// It is also the more legible of the two. Against white: 4.66:1 for this,
  /// 3.14:1 for what shipped -- the difference between passing WCAG AA for
  /// text and not.
  static const accent = primary500;
  static const errorPink = Color(0xFFFF6582);
  static const successAqua = Color(0xFF4CD4B0);

  // Pill backgrounds
  static const darkPillBg = Color(0xFF1F1F23);
  static const lightPillBg = Color(0xFFF7F7F7);

  // ===========================================================================
  // TYPOGRAPHY
  // ===========================================================================

  static const _fontFamily = 'Inter';

  // Font Sizes (from Bluesky ALF - 1.125 modular scale from 15px base)
  static const fontSize0 = 9.4;
  static const fontSize1 = 11.3;
  static const fontSize2 = 13.1;
  static const fontSize3 = 15.0; // Base
  static const fontSize4 = 16.9;
  static const fontSize5 = 18.8;
  static const fontSize6 = 20.6;
  static const fontSize7 = 24.3;
  static const fontSize8 = 30.0;
  static const fontSize9 = 37.5;

  // Line Heights
  static const lineHeightTight = 1.15;
  static const lineHeightSnug = 1.3;
  static const lineHeightRelaxed = 1.5;

  // ===========================================================================
  // SPACING
  // ===========================================================================

  static const space2 = 2.0;
  static const space4 = 4.0;
  static const space8 = 8.0;
  static const space12 = 12.0;
  static const space16 = 16.0;
  static const space20 = 20.0;
  static const space24 = 24.0;
  static const space28 = 28.0;
  static const space32 = 32.0;
  static const space40 = 40.0;

  // ===========================================================================
  // BORDER RADIUS
  // ===========================================================================

  static const radius2 = 2.0;
  static const radius4 = 4.0;
  static const radius8 = 8.0;
  static const radius12 = 12.0; // radius.md
  static const radius16 = 16.0;
  static const radius20 = 20.0; // Bottom sheet radius
  static const radiusFull = 999.0; // Pill shape

  /// How tall a full-width button is.
  ///
  /// Was 48 on Elevated and Outlined while FilledButton kept Material's own
  /// 40, so the same action was two different sizes depending on which class
  /// a screen happened to reach for -- the settings screens looked lighter
  /// than the sign-in screen for no reason anybody had chosen. One number
  /// now, and every button theme below reads it.
  static const buttonHeight = 40.0;

  // Named radii for clarity
  static const radiusSm = radius8;
  static const radiusMd = radius12;
  static const radiusLg = radius16;

  // ===========================================================================
  // MOTION
  // ===========================================================================

  static const motionMicro = Duration(milliseconds: 90); // Press states
  static const motionFast = Duration(milliseconds: 180); // Sheets closing
  static const motionNormal = Duration(milliseconds: 260); // Page pushes
  static const motionSlow = Duration(milliseconds: 420); // Hero animations

  // ===========================================================================
  // THEME DEFINITIONS
  // ===========================================================================

  /// Light Theme
  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      // Ripples are off everywhere, not just on the buttons whose themes
      // set it below. The philosophy names `splashFactory: NoSplash` as a
      // rule of the interface, but it was only ever applied to the four
      // button themes -- so every bare InkWell in the app still spread a
      // Material ink ring, which is the one press effect Kyron does not
      // use. Setting it on the theme itself is what makes the rule hold for
      // widgets nobody has written yet.
      splashFactory: NoSplash.splashFactory,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackgroundStart,
      canvasColor: lightSurface,
      colorScheme: ColorScheme.light(
        primary: accent,
        onPrimary: Colors.white,
        secondary: accent,
        onSecondary: Colors.white,
        surface: lightSurface,
        onSurface: lightTextPrimary,
        // The four container roles. Without them Flutter falls each one
        // back to `surface`, and everything drawn as a container comes out
        // the colour of the page behind it.
        surfaceContainerLowest: lightSurfaceLow,
        surfaceContainerLow: lightSurfaceLow,
        surfaceContainer: lightSurfaceContainer,
        surfaceContainerHigh: lightSurfaceHigh,
        surfaceContainerHighest: lightSurfaceHighest,
        error: errorPink,
        onError: Colors.white,
        primaryContainer: lightPillBg,
        onPrimaryContainer: lightTextPrimary,
      ),
      textTheme: _baseTextTheme(lightTextPrimary, lightTextSecondary),
      // Spelled out rather than inherited. Material 3 draws a
      // FloatingActionButton in `primaryContainer` on `onPrimaryContainer`,
      // and this file set the first and not the second -- so the light
      // theme's button came out a white glyph on a near-white disc,
      // measured at 1.06:1. Kyron's accent with a white glyph is 3.4:1 and
      // is what every other primary control here already is.
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: accent,
        foregroundColor: Colors.white,
        // The glyph is drawn by the caller, and Kyron's are outlined, so the
        // disc carries the weight rather than a filled shape inside it.
        elevation: 3,
        focusElevation: 3,
        hoverElevation: 4,
        highlightElevation: 6,
      ),
      inputDecorationTheme: _inputTheme(
        fill: lightPillBg,
        hint: lightTextSecondary,
      ),
      // The family is spelled out here, and it has to be. `textTheme` gets it
      // from `.apply(fontFamily:)` at the bottom of this file, but an AppBar's
      // `titleTextStyle` does not merge into the text theme -- it *becomes*
      // the DefaultTextStyle for the title. A style written without a family
      // therefore drops it, and every AppBar title in the app was being drawn
      // in whatever the platform handed back rather than in Kyron's type.
      appBarTheme: const AppBarTheme(
        // Flat when it is scrolled under, too.
        //
        // `elevation: 0` alone is not flat. Material 3 gives an app bar a
        // *second* elevation for when content has scrolled beneath it --
        // `scrolledUnderElevation`, which defaults to 3 -- and at any
        // elevation above zero it washes the bar with `surfaceTint`, which
        // defaults to the primary colour. So every app bar in Kyron turned
        // faintly blue the moment the page moved, and only then, which reads
        // as a rendering fault rather than a state.
        //
        // Both are set: the elevation because that is what triggers it, and
        // the tint to transparent because anything else that raises the bar
        // would bring the wash back.
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: _fontFamily,
          color: lightTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: lightTextPrimary),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusFull),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          animationDuration: motionMicro,
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(buttonHeight),
          backgroundColor: accent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusFull),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          animationDuration: motionMicro,
          splashFactory: NoSplash.splashFactory, // Disable ripples
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(buttonHeight),
          side: BorderSide(color: accent.withValues(alpha: 0.24)),
          foregroundColor: accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusFull),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          animationDuration: motionMicro,
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accent,
          animationDuration: motionMicro,
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0, // Flat interface
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius12),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: lightTextSecondary.withValues(alpha: 0.2),
        thickness: 1,
        space: 1,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: lightSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radius20),
          ),
        ),
      ),
    );
  }

  /// Dark Theme
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      // Ripples are off everywhere, not just on the buttons whose themes
      // set it below. The philosophy names `splashFactory: NoSplash` as a
      // rule of the interface, but it was only ever applied to the four
      // button themes -- so every bare InkWell in the app still spread a
      // Material ink ring, which is the one press effect Kyron does not
      // use. Setting it on the theme itself is what makes the rule hold for
      // widgets nobody has written yet.
      splashFactory: NoSplash.splashFactory,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      canvasColor: darkSurface,
      colorScheme: ColorScheme.dark(
        primary: accent,
        onPrimary: Colors.white,
        secondary: accent,
        onSecondary: Colors.white,
        surface: darkSurface,
        onSurface: darkTextPrimary,
        // The four container roles. Without them Flutter falls each one
        // back to `surface`, and everything drawn as a container comes out
        // the colour of the page behind it.
        surfaceContainerLowest: darkSurfaceLow,
        surfaceContainerLow: darkSurfaceLow,
        surfaceContainer: darkSurfaceContainer,
        surfaceContainerHigh: darkSurfaceHigh,
        surfaceContainerHighest: darkSurfaceHighest,
        error: errorPink,
        onError: Colors.white,
        primaryContainer: darkPillBg,
        onPrimaryContainer: darkTextPrimary,
      ),
      textTheme: _baseTextTheme(darkTextPrimary, darkTextSecondary),
      // Spelled out rather than inherited. Material 3 draws a
      // FloatingActionButton in `primaryContainer` on `onPrimaryContainer`,
      // and this file set the first and not the second -- so the light
      // theme's button came out a white glyph on a near-white disc,
      // measured at 1.06:1. Kyron's accent with a white glyph is 3.4:1 and
      // is what every other primary control here already is.
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: accent,
        foregroundColor: Colors.white,
        // The glyph is drawn by the caller, and Kyron's are outlined, so the
        // disc carries the weight rather than a filled shape inside it.
        elevation: 3,
        focusElevation: 3,
        hoverElevation: 4,
        highlightElevation: 6,
      ),
      inputDecorationTheme: _inputTheme(
        fill: const Color(0xFF111114),
        hint: darkTextSecondary,
      ),
      appBarTheme: const AppBarTheme(
        // Flat when it is scrolled under, too.
        //
        // `elevation: 0` alone is not flat. Material 3 gives an app bar a
        // *second* elevation for when content has scrolled beneath it --
        // `scrolledUnderElevation`, which defaults to 3 -- and at any
        // elevation above zero it washes the bar with `surfaceTint`, which
        // defaults to the primary colour. So every app bar in Kyron turned
        // faintly blue the moment the page moved, and only then, which reads
        // as a rendering fault rather than a state.
        //
        // Both are set: the elevation because that is what triggers it, and
        // the tint to transparent because anything else that raises the bar
        // would bring the wash back.
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: _fontFamily,
          color: darkTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: darkTextPrimary),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusFull),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          animationDuration: motionMicro,
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(buttonHeight),
          backgroundColor: accent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusFull),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          animationDuration: motionMicro,
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(buttonHeight),
          side: BorderSide(color: accent.withValues(alpha: 0.24)),
          foregroundColor: accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusFull),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          animationDuration: motionMicro,
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accent,
          animationDuration: motionMicro,
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius12),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: darkTextSecondary.withValues(alpha: 0.2),
        thickness: 1,
        space: 1,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radius20),
          ),
        ),
      ),
    );
  }

  /// Dim Theme (Default Dark)
  static ThemeData get dimTheme {
    return ThemeData.dark().copyWith(
      // Ripples are off everywhere, not just on the buttons whose themes
      // set it below. The philosophy names `splashFactory: NoSplash` as a
      // rule of the interface, but it was only ever applied to the four
      // button themes -- so every bare InkWell in the app still spread a
      // Material ink ring, which is the one press effect Kyron does not
      // use. Setting it on the theme itself is what makes the rule hold for
      // widgets nobody has written yet.
      splashFactory: NoSplash.splashFactory,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: dimContrast[0]!,
      canvasColor: dimContrast[50]!,
      colorScheme: ColorScheme.dark(
        primary: accent,
        onPrimary: Colors.white,
        secondary: accent,
        onSecondary: Colors.white,
        surface: dimContrast[50]!,
        onSurface: dimContrast[1000]!,
        // The four container roles. Without them Flutter falls each one
        // back to `surface`, and everything drawn as a container comes out
        // the colour of the page behind it.
        surfaceContainerLowest: dimSurfaceLow,
        surfaceContainerLow: dimSurfaceLow,
        surfaceContainer: dimSurfaceContainer,
        surfaceContainerHigh: dimSurfaceHigh,
        surfaceContainerHighest: dimSurfaceHighest,
        error: errorPink,
        onError: Colors.white,
        // dimContrast[50] is `surface`, so this role was invisible too --
        // a pill drawn in exactly the colour of the page it sits on. The
        // light and dark themes each step their pill up by a little; this
        // is the same step on dim.
        primaryContainer: dimSurfaceLow,
        onPrimaryContainer: dimContrast[1000]!,
      ),
      textTheme: _baseTextTheme(dimContrast[1000]!, dimContrast[700]!),
      // Spelled out rather than inherited. Material 3 draws a
      // FloatingActionButton in `primaryContainer` on `onPrimaryContainer`,
      // and this file set the first and not the second -- so the light
      // theme's button came out a white glyph on a near-white disc,
      // measured at 1.06:1. Kyron's accent with a white glyph is 3.4:1 and
      // is what every other primary control here already is.
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: accent,
        foregroundColor: Colors.white,
        // The glyph is drawn by the caller, and Kyron's are outlined, so the
        // disc carries the weight rather than a filled shape inside it.
        elevation: 3,
        focusElevation: 3,
        hoverElevation: 4,
        highlightElevation: 6,
      ),
      inputDecorationTheme: _inputTheme(
        fill: dimContrast[50]!,
        hint: dimContrast[700]!,
      ),
      appBarTheme: AppBarTheme(
        // Flat when it is scrolled under, too.
        //
        // `elevation: 0` alone is not flat. Material 3 gives an app bar a
        // *second* elevation for when content has scrolled beneath it --
        // `scrolledUnderElevation`, which defaults to 3 -- and at any
        // elevation above zero it washes the bar with `surfaceTint`, which
        // defaults to the primary colour. So every app bar in Kyron turned
        // faintly blue the moment the page moved, and only then, which reads
        // as a rendering fault rather than a state.
        //
        // Both are set: the elevation because that is what triggers it, and
        // the tint to transparent because anything else that raises the bar
        // would bring the wash back.
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: _fontFamily,
          color: dimContrast[1000]!,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: dimContrast[1000]!),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusFull),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          animationDuration: motionMicro,
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(buttonHeight),
          backgroundColor: accent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusFull),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          animationDuration: motionMicro,
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: dimContrast[50]!,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius12),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: dimContrast[100]!.withValues(alpha: 0.3),
        thickness: 1,
        space: 1,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: dimContrast[50]!,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radius20),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TEXT THEME
  // ===========================================================================

  static TextTheme _baseTextTheme(Color primary, Color secondary) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: fontSize8, // 30
        fontWeight: FontWeight.w700,
        color: primary,
        letterSpacing: 0,
        height: lineHeightTight,
      ),
      displayMedium: TextStyle(
        fontSize: fontSize7, // 24.3
        fontWeight: FontWeight.w700,
        color: primary,
        letterSpacing: 0,
        height: lineHeightTight,
      ),
      displaySmall: TextStyle(
        fontSize: fontSize6, // 20.6
        fontWeight: FontWeight.w600,
        color: primary,
        letterSpacing: 0,
        height: lineHeightTight,
      ),
      headlineLarge: TextStyle(
        fontSize: fontSize6, // 20.6
        fontWeight: FontWeight.w600,
        color: primary,
        letterSpacing: 0,
        height: lineHeightSnug,
      ),
      headlineMedium: TextStyle(
        fontSize: fontSize5, // 18.8
        fontWeight: FontWeight.w600,
        color: primary,
        letterSpacing: 0,
        height: lineHeightSnug,
      ),
      headlineSmall: TextStyle(
        fontSize: fontSize4, // 16.9
        fontWeight: FontWeight.w600,
        color: primary,
        letterSpacing: 0,
        height: lineHeightSnug,
      ),
      titleLarge: TextStyle(
        fontSize: fontSize3, // 15
        fontWeight: FontWeight.w600,
        color: primary,
        letterSpacing: 0,
        height: lineHeightSnug,
      ),
      titleMedium: TextStyle(
        fontSize: fontSize2, // 13.1
        fontWeight: FontWeight.w600,
        color: primary,
        letterSpacing: 0,
        height: lineHeightSnug,
      ),
      titleSmall: TextStyle(
        fontSize: fontSize1, // 11.3
        fontWeight: FontWeight.w600,
        color: primary,
        letterSpacing: 0,
        height: lineHeightSnug,
      ),
      bodyLarge: TextStyle(
        fontSize: fontSize4, // 16.9
        fontWeight: FontWeight.w400,
        color: primary,
        letterSpacing: 0,
        height: lineHeightRelaxed,
      ),
      bodyMedium: TextStyle(
        fontSize: fontSize3, // 15
        fontWeight: FontWeight.w400,
        color: primary,
        letterSpacing: 0,
        height: lineHeightRelaxed,
      ),
      bodySmall: TextStyle(
        fontSize: fontSize2, // 13.1
        fontWeight: FontWeight.w400,
        color: secondary,
        letterSpacing: 0,
        height: lineHeightRelaxed,
      ),
      labelLarge: TextStyle(
        fontSize: fontSize4, // 16.9
        fontWeight: FontWeight.w500,
        color: primary,
        letterSpacing: 0,
        height: lineHeightSnug,
      ),
      labelMedium: TextStyle(
        fontSize: fontSize3, // 15
        fontWeight: FontWeight.w500,
        color: primary,
        letterSpacing: 0,
        height: lineHeightSnug,
      ),
      labelSmall: TextStyle(
        fontSize: fontSize2, // 13.1
        fontWeight: FontWeight.w500,
        color: secondary,
        letterSpacing: 0,
        height: lineHeightSnug,
      ),
    ).apply(fontFamily: _fontFamily);
  }

  /// The look of every text field in the ecosystem.
  ///
  /// Written once because the three themes had three copies of it that had
  /// already drifted: the light one carried a visible border and the other two
  /// did not. All three used 16 logical pixels of vertical padding, which put
  /// a 56-pixel-tall box around a single line of text -- the "bulky" part.
  ///
  /// Filled and borderless at rest, with the outline appearing only on focus.
  /// A resting outline plus a fill draws the same edge twice.
  /// How tall a text field is, everywhere.
  ///
  /// Stated once so a screen that wants a field beside a button can line the
  /// two up without guessing, and so no screen has to reach for its own
  /// padding to look like the rest of the app.
  static const double fieldHeight = 44;

  static InputDecorationTheme _inputTheme({
    required Color fill,
    required Color hint,
  }) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fill,
      isDense: true,
      // Every field is the same height, whatever text size it carries.
      //
      // Padding alone does not settle it: a field at 16pt is taller than one
      // at 14pt for the same padding, which is how the search box ended up
      // being the one that looked right and everything else looked short. A
      // floor on the box settles it once, and 44 is the size of a comfortable
      // tap target -- the number Material and Apple both land on.
      constraints: const BoxConstraints(minHeight: fieldHeight),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      // Labels and hints at the size of the text they sit above, rather than
      // Material's default 16 -- which was larger than the body text in most
      // of the app and made every form look shouted.
      labelStyle: TextStyle(color: hint, fontSize: 14),
      floatingLabelStyle: const TextStyle(color: accent, fontSize: 13),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius12),
        borderSide: const BorderSide(color: accent, width: 1.4),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius12),
        borderSide: const BorderSide(color: errorPink),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius12),
        borderSide: const BorderSide(color: errorPink, width: 1.4),
      ),
      hintStyle:
          TextStyle(color: hint, fontSize: 14, fontWeight: FontWeight.w400),
      // Off by default. A counter under every field is noise on the ones that
      // are nowhere near their limit; a screen that wants one says so.
      counterStyle: TextStyle(color: hint, fontSize: 11),
    );
  }

  // ===========================================================================
  // UTILITY EXTENSIONS
  // ===========================================================================
}

// Extension for easy access to theme colors
extension ThemeColors on BuildContext {
  Color get surfaceColor => Theme.of(this).brightness == Brightness.dark
      ? KyronTheme.darkSurface
      : KyronTheme.lightSurface;

  Color get onSurfaceColor => Theme.of(this).brightness == Brightness.dark
      ? KyronTheme.darkTextPrimary
      : KyronTheme.lightTextPrimary;

  Color get pillBgColor => Theme.of(this).brightness == Brightness.dark
      ? KyronTheme.darkPillBg
      : KyronTheme.lightPillBg;

  Color get accentColor => KyronTheme.accent;

  Color get errorColor => KyronTheme.errorPink;

  Color get successColor => KyronTheme.successAqua;
}

// Extension for spacing
extension Spacing on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
  EdgeInsets get all => EdgeInsets.all(toDouble());
  EdgeInsets get hPad => EdgeInsets.symmetric(horizontal: toDouble());
  EdgeInsets get vPad => EdgeInsets.symmetric(vertical: toDouble());
}

// Radius helpers live in tokens.dart as RadiusExtensions. They were declared
// here too, as `extension Radius on num`, which shadowed Flutter's own Radius
// class throughout this file and broke every Radius.circular in it.
