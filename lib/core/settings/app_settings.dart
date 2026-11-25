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

/// Locally remembered appearance settings (Annexe D.1: "le changement de theme
/// est memorise").
///
/// Theme mode, accent and density are read by the theme itself, and the
/// language override is applied by `TaskFlowApp`. [textScale] is stored from
/// the start so that the text-size slider of step 7 needs no new storage
/// format, but no screen exposes it yet: it stays at 1.
@immutable
class AppSettings {
  const AppSettings({
    this.themeMode = AppThemeMode.system,
    this.accentColor = AppColors.defaultAccent,
    this.density = AppDensity.comfortable,
    this.languageCode,
    this.textScale = 1,
  });

  final AppThemeMode themeMode;
  final Color accentColor;
  final AppDensity density;

  /// Locale override chosen in Settings > Language; `null` follows the system
  /// language. Only the language codes of `AppLocalizations.supportedLocales`
  /// are meaningful here.
  final String? languageCode;

  /// User text scale factor (1 = system default).
  final double textScale;

  /// [clearLanguage] is needed because `null` is a meaningful language value
  /// ("follow the system"), so it cannot be expressed by an omitted parameter.
  AppSettings copyWith({
    AppThemeMode? themeMode,
    Color? accentColor,
    AppDensity? density,
    String? languageCode,
    bool clearLanguage = false,
    double? textScale,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      accentColor: accentColor ?? this.accentColor,
      density: density ?? this.density,
      languageCode: clearLanguage ? null : (languageCode ?? this.languageCode),
      textScale: textScale ?? this.textScale,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AppSettings &&
        other.themeMode == themeMode &&
        other.accentColor == accentColor &&
        other.density == density &&
        other.languageCode == languageCode &&
        other.textScale == textScale;
  }

  @override
  int get hashCode =>
      Object.hash(themeMode, accentColor, density, languageCode, textScale);
}
