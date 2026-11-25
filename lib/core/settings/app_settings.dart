import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Theme choice of Settings > Appearance (Annexe D.1: Système is the default).
enum AppThemeMode {
  system,
  light,
  dark;

  ThemeMode get materialMode => switch (this) {
        AppThemeMode.system => ThemeMode.system,
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
      };
}

/// Density choice of Settings > Appearance (Annexe D.3, point 3).
enum AppDensity {
  comfortable,
  compact;

  VisualDensity get visualDensity => switch (this) {
        AppDensity.comfortable => VisualDensity.standard,
        AppDensity.compact => VisualDensity.compact,
      };
}

/// Locally remembered appearance settings.
///
/// Only the two settings required by step 0 are stored: theme mode and accent
/// colour. Text size and density (Annexe D.3.3) are modelled here so the
/// settings screen of step 7 can reuse them without a new storage format.
@immutable
class AppSettings {
  const AppSettings({
    this.themeMode = AppThemeMode.system,
    this.accentColor = AppColors.defaultAccent,
    this.density = AppDensity.comfortable,
    this.textScale = 1,
  });

  final AppThemeMode themeMode;
  final Color accentColor;
  final AppDensity density;

  /// User text scale factor (1 = system default).
  final double textScale;

  AppSettings copyWith({
    AppThemeMode? themeMode,
    Color? accentColor,
    AppDensity? density,
    double? textScale,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      accentColor: accentColor ?? this.accentColor,
      density: density ?? this.density,
      textScale: textScale ?? this.textScale,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AppSettings &&
        other.themeMode == themeMode &&
        other.accentColor == accentColor &&
        other.density == density &&
        other.textScale == textScale;
  }

  @override
  int get hashCode => Object.hash(themeMode, accentColor, density, textScale);
}
