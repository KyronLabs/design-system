import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:kyron_design_system/kyron_design_system.dart';

/// `desktop/tokens.css` is the same palette in the form a desktop application
/// built on a web view can read.
///
/// A second copy of a palette is exactly how #4C8FFF shipped in place of
/// #006AFF for twenty-six controls, and then survived the correction in a
/// third place because nothing compared them. So this reads the CSS and
/// fails if any colour in it disagrees with the Dart it was copied from.
void main() {
  final css = File('../desktop/tokens.css');

  /// Every `--name: #rrggbb;` in the file, lowercased.
  Map<String, String> declarations() {
    final found = <String, String>{};
    final pattern = RegExp(r'--([a-z0-9-]+):\s*(#[0-9a-fA-F]{6})\s*;');
    for (final match in pattern.allMatches(css.readAsStringSync())) {
      found[match.group(1)!] = match.group(2)!.toLowerCase();
    }
    return found;
  }

  /// A Dart token as the CSS would spell it.
  String hex(int argb) =>
      '#${(argb & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';

  group('the desktop CSS carries the same palette as the Dart', () {
    test('the file is there and has colours in it', () {
      // A path that does not resolve makes every test below pass by finding
      // nothing to disagree with.
      expect(css.existsSync(), isTrue,
          reason: '${css.absolute.path} is missing');
      expect(declarations().length, greaterThan(40));
    });

    test('every ramp step matches', () {
      final found = declarations();
      final ramps = <String, List<int>>{
        'contrast': ContrastRamp.values,
        'primary': PrimaryRamp.values,
        'dim': DimContrastRamp.values,
      };
      const steps = [0, 50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000];

      final wrong = <String>[];
      ramps.forEach((name, values) {
        for (var at = 0; at < steps.length; at++) {
          final key = '$name-${steps[at]}';
          final want = hex(values[at]);
          final got = found[key];
          if (got == null) {
            wrong.add('--$key is missing; the Dart says $want');
          } else if (got != want) {
            wrong.add('--$key is $got; the Dart says $want');
          }
        }
      });
      expect(wrong, isEmpty, reason: wrong.join('\n'));
    });

    test('the accent is the accent, in all three places it is written', () {
      final found = declarations();
      expect(found['primary-500'], hex(PrimaryRamp.step500));
      expect(found['primary-500'], hex(SemanticColors.accent));
      expect(found['primary-500'], hex(KyronTheme.accent.toARGB32()));
      expect(found['primary-500'], '#006aff');
    });

    test('the type scale matches', () {
      final sizes = RegExp(r'--font-(\d):\s*([0-9.]+)px;')
          .allMatches(css.readAsStringSync());
      final scale = [
        TypographyTokens.fontSize0,
        TypographyTokens.fontSize1,
        TypographyTokens.fontSize2,
        TypographyTokens.fontSize3,
        TypographyTokens.fontSize4,
        TypographyTokens.fontSize5,
        TypographyTokens.fontSize6,
        TypographyTokens.fontSize7,
        TypographyTokens.fontSize8,
        TypographyTokens.fontSize9,
      ];
      expect(sizes.length, scale.length);
      for (final match in sizes) {
        final at = int.parse(match.group(1)!);
        expect(double.parse(match.group(2)!), closeTo(scale[at], 0.05),
            reason:
                '--font-$at is ${match.group(2)}, the Dart says ${scale[at]}');
      }
    });

    test('the spacing scale matches', () {
      final found = RegExp(r'--space-(\d+):\s*(\d+)px;')
          .allMatches(css.readAsStringSync())
          .map((it) => int.parse(it.group(2)!))
          .toList();
      expect(found, SpacingTokens.values.map((it) => it.toInt()).toList());
    });

    test('the motion scale matches', () {
      final found = <String, int>{
        for (final match
            in RegExp(r'--motion-(micro|fast|normal|slow):\s*(\d+)ms;')
                .allMatches(css.readAsStringSync()))
          match.group(1)!: int.parse(match.group(2)!),
      };
      expect(found['micro'], MotionTokens.micro.inMilliseconds);
      expect(found['fast'], MotionTokens.fast.inMilliseconds);
      expect(found['normal'], MotionTokens.normal.inMilliseconds);
      expect(found['slow'], MotionTokens.slow.inMilliseconds);
    });
  });
}
