import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/core/theme/app_colors.dart';
import 'package:taskflow/core/theme/app_theme.dart';
import 'package:taskflow/core/theme/app_theme_extension.dart';
import 'package:taskflow/core/theme/contrast.dart';

void main() {
  group('Contrast', () {
    test('computes the WCAG ratio of known pairs', () {
      expect(
        Contrast.ratio(Colors.black, Colors.white),
        closeTo(21, 0.01),
      );
      expect(Contrast.ratio(Colors.white, Colors.white), closeTo(1, 0.01));
    });

    test('readable() lifts text to the 4.5:1 requirement', () {
      final AppColors light = AppColors.light();
      final Color adjusted =
          Contrast.readable(const Color(0xFF6B7280), light.background);

      expect(
        Contrast.ratio(adjusted, light.background),
        greaterThanOrEqualTo(Contrast.minTextRatio),
      );
    });

    test('backgroundFor() keeps the chosen text readable', () {
      // The turquoise rail of the light theme: white icons are not readable
      // on the raw tint, so the surface is darkened.
      final Color surface =
          Contrast.backgroundFor(Colors.white, const Color(0xFF369081));

      expect(
        Contrast.ratio(Colors.white, surface),
        greaterThanOrEqualTo(Contrast.minTextRatio),
      );
      expect(surface, isNot(const Color(0xFF369081)));
      // A background that is already fine is returned unchanged.
      expect(
        Contrast.backgroundFor(Colors.black, Colors.white),
        Colors.white,
      );
    });
  });

  group('AppColors tokens', () {
    test('match the values of Annexe D.2', () {
      final AppColors light = AppColors.light();
      final AppColors dark = AppColors.dark();

      expect(light.background, const Color(0xFFF1F3F9));
      expect(light.surface, const Color(0xFFFFFFFF));
      expect(light.surfaceSidebar, const Color(0xFFF5F6FA));
      expect(light.rail, const Color(0xFF1F3FA8));
      expect(light.selected, const Color(0xFFEDEFFB));
      expect(light.input, const Color(0xFFF1F3F9));
      expect(light.textPrimary, const Color(0xFF1A1C1E));
      expect(light.textSecondary, const Color(0xFF6B7280));
      expect(light.divider, const Color(0xFFE5E7EB));
      expect(light.danger, const Color(0xFFD52B24));
      expect(light.success, const Color(0xFF2E9E5B));
      expect(light.premium, const Color(0xFFF59E0B));

      expect(dark.background, const Color(0xFF14171A));
      expect(dark.surface, const Color(0xFF1D2125));
      expect(dark.surfaceSidebar, const Color(0xFF1F2428));
      expect(dark.rail, const Color(0xFF1B3A44));
      expect(dark.selected, const Color(0xFF2B3136));
      expect(dark.input, const Color(0xFF272C30));
      expect(dark.textPrimary, const Color(0xFFE8EAED));
      expect(dark.textSecondary, const Color(0xFF9AA0A6));
      expect(dark.divider, const Color(0xFF2E3338));
      expect(dark.danger, const Color(0xFFE5484D));
      expect(dark.priorityLow, const Color(0xFF6A8DFF));
    });

    test('expose the default accent and the 8 colour palette', () {
      expect(AppColors.defaultAccent, const Color(0xFF4772FA));
      expect(AppColors.accentPalette, hasLength(8));
      expect(AppColors.accentPalette, contains(const Color(0xFF3FA796)));
    });
  });

  group('AppTheme', () {
    // Every accent offered in Settings > Appearance has to satisfy the rules,
    // not only the default blue and the turquoise option.
    for (final Color accent in AppColors.accentPalette) {
      test('light and dark themes meet the contrast rules ($accent)', () {
        for (final ThemeData theme in <ThemeData>[
          AppTheme.light(accent),
          AppTheme.dark(accent),
        ]) {
          final AppColors tokens = theme.extension<AppColorsTheme>()!.colors;

          expect(
            Contrast.ratio(tokens.textPrimary, tokens.background),
            greaterThanOrEqualTo(Contrast.minTextRatio),
          );
          expect(
            Contrast.ratio(tokens.textSecondary, tokens.background),
            greaterThanOrEqualTo(Contrast.minTextRatio),
          );
          expect(
            Contrast.ratio(tokens.textSecondary, tokens.surface),
            greaterThanOrEqualTo(Contrast.minTextRatio),
          );
          expect(
            Contrast.ratio(tokens.onRail, tokens.rail),
            greaterThanOrEqualTo(Contrast.minTextRatio),
          );
          for (final Color priority in <Color>[
            tokens.priorityHigh,
            tokens.priorityMedium,
            tokens.priorityLow,
            tokens.priorityNone,
          ]) {
            expect(
              Contrast.ratio(priority, tokens.surface),
              greaterThanOrEqualTo(Contrast.minGraphicRatio),
            );
          }
          expect(
            Contrast.ratio(
              theme.colorScheme.onPrimary,
              theme.colorScheme.primary,
            ),
            greaterThanOrEqualTo(Contrast.minTextRatio),
          );
        }
      });
    }

    test('dark theme reports a dark brightness and light a light one', () {
      expect(
        AppTheme.light(AppColors.defaultAccent).brightness,
        Brightness.light,
      );
      expect(
        AppTheme.dark(AppColors.defaultAccent).brightness,
        Brightness.dark,
      );
    });

    test('accent colour drives the primary colour scheme entry', () {
      final ThemeData theme = AppTheme.light(const Color(0xFF3FA796));
      final AppColors tokens = theme.extension<AppColorsTheme>()!.colors;

      expect(theme.colorScheme.primary, tokens.accentedColor);
      expect(theme.colorScheme.primary, isNot(AppColors.defaultAccent));
    });

    test('component themes use the token types of Flutter 3.35', () {
      // `ThemeData.appBarTheme` is typed `Object?` and silently accepts the
      // inherited `AppBarTheme` widget; passing the data class keeps the value
      // analysable and lets the test read it back without a cast.
      final ThemeData theme = AppTheme.light(AppColors.defaultAccent);
      expect(theme.appBarTheme, isA<AppBarThemeData>());
      expect(
        theme.appBarTheme.backgroundColor,
        theme.extension<AppColorsTheme>()!.colors.background,
      );
    });

    test('bottom bar hides its labels, as required on mobile', () {
      final ThemeData theme = AppTheme.light(AppColors.defaultAccent);
      expect(
        theme.navigationBarTheme.labelBehavior,
        NavigationDestinationLabelBehavior.alwaysHide,
      );
    });
  });
}
