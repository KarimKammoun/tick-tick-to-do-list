import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/app_colors.dart';
import 'app_settings.dart';

/// Storage contract for [AppSettings].
abstract interface class SettingsRepository {
  /// Reads the stored settings synchronously; the caller loads the backing
  /// store once during application start-up.
  AppSettings read();

  Future<void> write(AppSettings settings);
}

/// [SettingsRepository] backed by `shared_preferences`.
///
/// SharedPreferences is the smallest dependency able to persist two scalars on
/// both Android and Windows, and it is the store recommended by the Flutter
/// team. It is installed in step 0 only for the appearance settings agreed in
/// Annexe D.1 ("le changement de thème est mémorisé"); task data lives in Drift.
class SharedPreferencesSettingsRepository implements SettingsRepository {
  SharedPreferencesSettingsRepository(this._preferences);

  final SharedPreferences _preferences;

  static const String _themeKey = 'settings.themeMode';
  static const String _accentKey = 'settings.accentColor';
  static const String _densityKey = 'settings.density';
  static const String _textScaleKey = 'settings.textScale';

  @override
  AppSettings read() {
    final String? themeName = _preferences.getString(_themeKey);
    final int? accentValue = _preferences.getInt(_accentKey);
    final String? densityName = _preferences.getString(_densityKey);
    final double? textScale = _preferences.getDouble(_textScaleKey);

    return AppSettings(
      themeMode: AppThemeMode.values.firstWhere(
        (AppThemeMode mode) => mode.name == themeName,
        orElse: () => AppThemeMode.system,
      ),
      accentColor: accentValue == null
          ? AppColors.defaultAccent
          : Color(accentValue),
      density: AppDensity.values.firstWhere(
        (AppDensity density) => density.name == densityName,
        orElse: () => AppDensity.comfortable,
      ),
      textScale: textScale ?? 1,
    );
  }

  @override
  Future<void> write(AppSettings settings) async {
    await _preferences.setString(_themeKey, settings.themeMode.name);
    await _preferences.setInt(_accentKey, settings.accentColor.toARGB32());
    await _preferences.setString(_densityKey, settings.density.name);
    await _preferences.setDouble(_textScaleKey, settings.textScale);
  }
}
