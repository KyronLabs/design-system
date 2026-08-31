/// Design tokens and the Flutter theme for the Kyron ecosystem.
///
/// This package exists so applications consume the design system rather than
/// copying it. The Flutter client previously kept a hand-written theme of its
/// own, which had drifted into a separate vocabulary -- `background` where
/// this says `darkBackground`, and nothing at all for the ALF ramps. Copying
/// was the only mechanism available, so drift was the only possible outcome.
///
/// Import it whole:
///
/// ```dart
/// import 'package:kyron_design_system/kyron_design_system.dart';
///
/// MaterialApp(theme: KyronTheme.lightTheme, darkTheme: KyronTheme.darkTheme);
/// ```
library;

export 'src/theme.dart';
export 'src/tokens.dart';
