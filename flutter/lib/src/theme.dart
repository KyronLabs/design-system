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
    500: Color(0xFF006AFF), // DEFAULT ACCENT
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
  static const lightTextPrimary = Color(0xFF1A202C);
  static const lightTextSecondary = Color(0xFF718096);

  // Dark Theme Colors
  static const darkBackground = Color(0xFF0D0D0F);
  static const darkSurface = Color(0xFF1A1A1D);
  static const darkTextPrimary = Color(0xFFE5EBF5);
  static const darkTextSecondary = Color(0xFF7E8A9A);

  // Shared Colors
  static const accent = Color(0xFF4C8FFF);
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
        error: errorPink,
        onError: Colors.white,
        primaryContainer: lightPillBg,
      ),
      textTheme: _baseTextTheme(lightTextPrimary, lightTextSecondary),
      inputDecorationTheme: _inputTheme(
        fill: lightPillBg,
        hint: lightTextSecondary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: lightTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: lightTextPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
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
          minimumSize: const Size.fromHeight(48),
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
        error: errorPink,
        onError: Colors.white,
        primaryContainer: darkPillBg,
      ),
      textTheme: _baseTextTheme(darkTextPrimary, darkTextSecondary),
      inputDecorationTheme: _inputTheme(
        fill: const Color(0xFF111114),
        hint: darkTextSecondary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: darkTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: darkTextPrimary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
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
          minimumSize: const Size.fromHeight(48),
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
        error: errorPink,
        onError: Colors.white,
        primaryContainer: dimContrast[50]!,
      ),
      textTheme: _baseTextTheme(dimContrast[1000]!, dimContrast[700]!),
      inputDecorationTheme: _inputTheme(
        fill: dimContrast[50]!,
        hint: dimContrast[700]!,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: dimContrast[1000]!,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: dimContrast[1000]!),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
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
