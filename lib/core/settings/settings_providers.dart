import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/app_theme.dart';
import 'app_settings.dart';
import 'settings_repository.dart';

/// Overridden in `main.dart` once `SharedPreferences` has been loaded.
final Provider<SettingsRepository> settingsRepositoryProvider =
    Provider<SettingsRepository>((Ref ref) {
      throw UnimplementedError(
        'settingsRepositoryProvider must be overridden during start-up.',
      );
    });

/// Current appearance settings, persisted on every change.
class AppSettingsController extends Notifier<AppSettings> {
  @override
  AppSettings build() => ref.read(settingsRepositoryProvider).read();

  Future<void> setThemeMode(AppThemeMode mode) =>
      _update(state.copyWith(themeMode: mode));

  Future<void> setAccentColor(Color color) =>
      _update(state.copyWith(accentColor: color));

  Future<void> setDensity(AppDensity density) =>
      _update(state.copyWith(density: density));

  /// Language of the interface; `null` means "follow the system language".
  Future<void> setLanguage(String? languageCode) => _update(
    languageCode == null
        ? state.copyWith(clearLanguage: true)
        : state.copyWith(languageCode: languageCode),
  );

  Future<void> _update(AppSettings settings) async {
    state = settings;
    await ref.read(settingsRepositoryProvider).write(settings);
  }
}

final NotifierProvider<AppSettingsController, AppSettings> appSettingsProvider =
    NotifierProvider<AppSettingsController, AppSettings>(
      AppSettingsController.new,
    );

/// Active theme data, rebuilt whenever the accent or the density changes.
final Provider<ThemeData> lightThemeProvider = Provider<ThemeData>((Ref ref) {
  final AppSettings settings = ref.watch(appSettingsProvider);
  return AppTheme.light(
    settings.accentColor,
    density: settings.density.visualDensity,
  );
});

/// Active dark theme data.
final Provider<ThemeData> darkThemeProvider = Provider<ThemeData>((Ref ref) {
  final AppSettings settings = ref.watch(appSettingsProvider);
  return AppTheme.dark(
    settings.accentColor,
    density: settings.density.visualDensity,
  );
});

/// Locale override chosen in Settings > Language, read from the remembered
/// settings so that the choice survives a restart; `null` follows the system
/// language.
final Provider<Locale?> appLocaleProvider = Provider<Locale?>((Ref ref) {
  final String? languageCode = ref.watch(appSettingsProvider).languageCode;
  return languageCode == null ? null : Locale(languageCode);
});
