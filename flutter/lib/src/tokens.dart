// Kyron Design System - Design Tokens for Flutter
// Based on Bluesky ALF (Application Layout Framework)

/// Design Tokens for the Kyron Design System
/// These tokens are the single source of truth for all design values
/// and should be used throughout the Flutter application.

library;

import 'package:flutter/material.dart';

// ===========================================================================
// COLOR TOKENS
// ===========================================================================

/// Color ramp with 13 steps (0-1000)
/// Used for backgrounds, text, borders in all themes
class ContrastRamp {
  static const int step0 = 0xFFFFFFFF; // Lightest
  static const int step50 = 0xFFF7F7F7;
  static const int step100 = 0xFFE8E8E8; // Hairline dividers
  static const int step200 = 0xFFD9D9D9; // Stronger borders
  static const int step300 = 0xFFC9C9C9; // Input borders
  static const int step400 = 0xFFB0B0B0; // Tertiary text, timestamps
  static const int step500 = 0xFF999999; // Secondary text
  static const int step600 = 0xFF737373;
  static const int step700 = 0xFF5C5C5C; // Body text
  static const int step800 = 0xFF3A3A3A;
  static const int step900 = 0xFF262626;
  static const int step1000 = 0xFF000000; // Darkest

  static const List<int> values = [
    step0,
    step50,
    step100,
    step200,
    step300,
    step400,
    step500,
    step600,
    step700,
    step800,
    step900,
    step1000
  ];
}

/// Primary color ramp (accent colors)
class PrimaryRamp {
  static const int step0 = 0xFFE6F0FF;
  static const int step50 = 0xFFCCE0FF;
  static const int step100 = 0xFFB3D1FF;
  static const int step200 = 0xFF99C2FF; // Disabled state
  static const int step300 = 0xFF80B3FF;
  static const int step400 = 0xFF66A4FF; // Hover state (dark theme)
  static const int step500 = 0xFF006AFF; // DEFAULT ACCENT
  static const int step600 = 0xFF005BCC; // Pressed state (light theme)
  static const int step700 = 0xFF004D99; // Disabled state (dark theme)
  static const int step800 = 0xFF003F80;
  static const int step900 = 0xFF003366;
  static const int step1000 = 0xFF00264D;

  static const List<int> values = [
    step0,
    step50,
    step100,
    step200,
    step300,
    step400,
    step500,
    step600,
    step700,
    step800,
    step900,
    step1000
  ];
}

/// Positive color ramp (success states)
class PositiveRamp {
  static const int step0 = 0xFFE6FFF0;
  static const int step50 = 0xFFCCFFE0;
  static const int step100 = 0xFFB3FFD1;
  static const int step200 = 0xFF99FFC2;
  static const int step300 = 0xFF80FFB3;
  static const int step400 = 0xFF66FFA4;
  static const int step500 = 0xFF4CD4B0; // successAqua
  static const int step600 = 0xFF42B896;
  static const int step700 = 0xFF389C7C;
  static const int step800 = 0xFF2E8062;
  static const int step900 = 0xFF246449;
  static const int step1000 = 0xFF1A4830;

  static const List<int> values = [
    step0,
    step50,
    step100,
    step200,
    step300,
    step400,
    step500,
    step600,
    step700,
    step800,
    step900,
    step1000
  ];
}

/// Negative color ramp (error states)
class NegativeRamp {
  static const int step0 = 0xFFFFE6E6;
  static const int step50 = 0xFFFFCCCC;
  static const int step100 = 0xFFFFB3B3;
  static const int step200 = 0xFFFF9999;
  static const int step300 = 0xFFFF8080;
  static const int step400 = 0xFFFF6666;
  static const int step500 = 0xFFFF4C4C;
  static const int step600 = 0xFFFF6582; // errorPink
  static const int step700 = 0xFFCC3D3D;
  static const int step800 = 0xFF992E2E;
  static const int step900 = 0xFF661F1F;
  static const int step1000 = 0xFF331010;

  static const List<int> values = [
    step0,
    step50,
    step100,
    step200,
    step300,
    step400,
    step500,
    step600,
    step700,
    step800,
    step900,
    step1000
  ];
}

/// Dim theme contrast ramp (subdued palette)
class DimContrastRamp {
  static const int step0 = 0xFF151D28; // Background
  static const int step50 = 0xFF1E2A38;
  static const int step100 = 0xFF2A3848; // Hairline dividers
  static const int step200 = 0xFF384858;
  static const int step300 = 0xFF485868;
  static const int step400 = 0xFF607080; // Tertiary text
  static const int step500 = 0xFF788898;
  static const int step600 = 0xFF90A0B0;
  static const int step700 = 0xFFA8B8C8; // Body text
  static const int step800 = 0xFFC0D0D8;
  static const int step900 = 0xFFD8E8F0;
  static const int step1000 = 0xFFF0F8FF; // Primary text

  static const List<int> values = [
    step0,
    step50,
    step100,
    step200,
    step300,
    step400,
    step500,
    step600,
    step700,
    step800,
    step900,
    step1000
  ];
}

// ===========================================================================
// SEMANTIC COLOR TOKENS
// ===========================================================================

/// Semantic colors that map to ramp values based on theme
class SemanticColors {
  // Light theme
  static const int lightBackground = 0xFFFFFFFF;
  static const int lightBackgroundStart = 0xFFFFFFFF;
  static const int lightBackgroundEnd = 0xFFF0F4F8;
  static const int lightSurface = 0xFFF8FAFC;
  static const int lightTextPrimary = 0xFF1A202C;
  static const int lightTextSecondary = 0xFF718096;

  // Dark theme
  static const int darkBackground = 0xFF0D0D0F;
  static const int darkSurface = 0xFF1A1A1D;
  static const int darkTextPrimary = 0xFFE5EBF5;
  static const int darkTextSecondary = 0xFF7E8A9A;

  // Shared
  static const int accent = 0xFF4C8FFF;
  static const int errorPink = 0xFFFF6582;
  static const int successAqua = 0xFF4CD4B0;

  // Pill backgrounds
  static const int darkPillBg = 0xFF1F1F23;
  static const int lightPillBg = 0xFFF7F7F7;
}

// ===========================================================================
// TYPOGRAPHY TOKENS
// ===========================================================================

/// Typography tokens based on Bluesky ALF
/// Font sizes use 1.125 modular scale from 15px base
class TypographyTokens {
  // Font sizes
  static const double fontSize0 = 9.4;
  static const double fontSize1 = 11.3;
  static const double fontSize2 = 13.1;
  static const double fontSize3 = 15.0; // Base size
  static const double fontSize4 = 16.9;
  static const double fontSize5 = 18.8;
  static const double fontSize6 = 20.6;
  static const double fontSize7 = 24.3;
  static const double fontSize8 = 30.0;
  static const double fontSize9 = 37.5;

  // Line heights
  static const double lineHeightTight = 1.15;
  static const double lineHeightSnug = 1.3;
  static const double lineHeightRelaxed = 1.5;

  // Font weights
  static const int fontWeightRegular = 400;
  static const int fontWeightMedium = 500;
  static const int fontWeightSemibold = 600;
  static const int fontWeightBold = 700;

  // Tracking (always 0)
  static const double tracking = 0.0;
}

// ===========================================================================
// SPACING TOKENS
// ===========================================================================

/// Spacing scale: 2, 4, 8, 12, 16, 20, 24, 28, 32, 40
class SpacingTokens {
  static const double space2 = 2.0;
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space28 = 28.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;

  static const List<double> values = [
    space2,
    space4,
    space8,
    space12,
    space16,
    space20,
    space24,
    space28,
    space32,
    space40
  ];
}

// ===========================================================================
// BORDER RADIUS TOKENS
// ===========================================================================

/// Border radius scale: 2, 4, 8, 12, 16, 20, 999
class RadiusTokens {
  static const double radius2 = 2.0;
  static const double radius4 = 4.0;
  static const double radius8 = 8.0; // radius.sm
  static const double radius12 = 12.0; // radius.md
  static const double radius16 = 16.0;
  static const double radius20 = 20.0; // Bottom sheet radius
  static const double radiusFull = 999.0; // Pill shape

  // Named radii for clarity
  static const double radiusSm = radius8;
  static const double radiusMd = radius12;
  static const double radiusLg = radius16;

  static const List<double> values = [
    radius2,
    radius4,
    radius8,
    radius12,
    radius16,
    radius20,
    radiusFull
  ];
}

// ===========================================================================
// MOTION TOKENS
// ===========================================================================

/// Motion durations based on Bluesky implementation
class MotionTokens {
  static const Duration micro = Duration(milliseconds: 90); // Press states
  static const Duration fast = Duration(milliseconds: 180); // Sheets closing
  static const Duration normal = Duration(milliseconds: 260); // Page pushes
  static const Duration slow = Duration(milliseconds: 420); // Hero animations
}

// ===========================================================================
// BUTTON TOKENS
// ===========================================================================

/// Button size configurations from Bluesky Button.tsx
class ButtonTokens {
  // Size configurations
  static const ButtonSize large = ButtonSize(
    paddingVertical: 12,
    paddingHorizontal: 24,
    gap: 6,
    fontSize: 15,
    fontWeight: 500,
    minHeight: 48,
  );

  static const ButtonSize small = ButtonSize(
    paddingVertical: 8,
    paddingHorizontal: 14,
    gap: 5,
    fontSize: 13.1,
    fontWeight: 500,
    minHeight: 40,
  );

  static const ButtonSize tiny = ButtonSize(
    paddingVertical: 5,
    paddingHorizontal: 10,
    gap: 3,
    fontSize: 11.3,
    fontWeight: 600,
    minHeight: 32,
  );

  // Press interaction
  static const double pressScale = 0.97;
  static const double pressOpacity = 0.85;
}

/// Button size configuration
class ButtonSize {
  final double paddingVertical;
  final double paddingHorizontal;
  final double gap;
  final double fontSize;
  final int fontWeight;
  final double minHeight;

  const ButtonSize({
    required this.paddingVertical,
    required this.paddingHorizontal,
    required this.gap,
    required this.fontSize,
    required this.fontWeight,
    required this.minHeight,
  });
}

// ===========================================================================
// THREAD TOKENS
// ===========================================================================

/// Thread geometry from ThreadGeometry
class ThreadTokens {
  static const double indent = 30.0; // One avatar radius + gutter
  static const double thickness = 2.0; // 1px too thin, reads as hairline
  static const double corner = 12.0; // Half the indent, quarter-circle turns
  static const int maxIndent = 4; // Prevents running off screen
}

// ===========================================================================
// HAPTICS TOKENS
// ===========================================================================

/// Haptics configuration
class HapticsTokens {
  // Throttle duration for micro-haptics
  static const Duration throttleDuration = Duration(milliseconds: 40);

  // Gap between compound pattern pulses
  static const Duration compoundGap = Duration(milliseconds: 90);

  // Platform behavior
  static const bool clampAndroidToLight = true;
}

// ===========================================================================
// EXTENSION METHODS
// ===========================================================================

/// Extension for easy access to spacing tokens
extension SpacingExtensions on num {
  /// Horizontal spacing
  SizedBox get h => SizedBox(height: toDouble());

  /// Vertical spacing
  SizedBox get w => SizedBox(width: toDouble());

  /// Padding on all sides
  EdgeInsets get pad => EdgeInsets.all(toDouble());

  /// Horizontal padding
  EdgeInsets get hPad => EdgeInsets.symmetric(horizontal: toDouble());

  /// Vertical padding
  EdgeInsets get vPad => EdgeInsets.symmetric(vertical: toDouble());

  /// Only top padding
  EdgeInsets get tPad => EdgeInsets.only(top: toDouble());

  /// Only bottom padding
  EdgeInsets get bPad => EdgeInsets.only(bottom: toDouble());

  /// Only left padding
  EdgeInsets get lPad => EdgeInsets.only(left: toDouble());

  /// Only right padding
  EdgeInsets get rPad => EdgeInsets.only(right: toDouble());
}

/// Extension for easy access to radius tokens
extension RadiusExtensions on num {
  /// BorderRadius on all corners
  BorderRadius get radius => BorderRadius.all(Radius.circular(toDouble()));

  /// Radius for single corner
  Radius get r => Radius.circular(toDouble());

  /// BorderRadius with only top-left and top-right
  BorderRadius get topRadius => BorderRadius.vertical(
        top: Radius.circular(toDouble()),
      );

  /// BorderRadius with only bottom-left and bottom-right
  BorderRadius get bottomRadius => BorderRadius.vertical(
        bottom: Radius.circular(toDouble()),
      );
}

/// Extension for color access
extension ColorExtensions on int {
  Color get color => Color(this);
}

/// Extension for duration access
extension DurationExtensions on int {
  Duration get ms => Duration(milliseconds: this);
}
