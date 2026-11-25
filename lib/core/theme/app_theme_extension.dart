import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Exposes the Annexe D.2 colour tokens to widgets through
/// `Theme.of(context).extension<AppColorsTheme>()`.
@immutable
class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  const AppColorsTheme(this.colors);

  final AppColors colors;

  @override
  AppColorsTheme copyWith({AppColors? colors}) =>
      AppColorsTheme(colors ?? this.colors);

  @override
  AppColorsTheme lerp(ThemeExtension<AppColorsTheme>? other, double t) {
    if (other is! AppColorsTheme) {
      return this;
    }
    return t < 0.5 ? this : other;
  }
}

/// Shortcut to the design tokens: `context.colors.surface`.
extension AppThemeContext on BuildContext {
  AppColorsTheme get _theme =>
      Theme.of(this).extension<AppColorsTheme>() ??
      AppColorsTheme(
        Theme.of(this).brightness == Brightness.dark
            ? AppColors.dark()
            : AppColors.light(),
      );

  /// Colour tokens of the current theme.
  AppColors get colors => _theme.colors;
}
