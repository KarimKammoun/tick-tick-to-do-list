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

  Future<void> _update(AppSettings settings) async {
    state = settings;
    await ref.read(settingsRepositoryProvider).write(settings);
  }
}

final NotifierProvider<AppSettingsController, AppSettings> appSettingsProvider =
    NotifierProvider<AppSettingsController, AppSettings>(
  AppSettingsController.new,
);

/// Active theme data, rebuilt whenever the theme mode or accent changes.
final Provider<ThemeData> lightThemeProvider = Provider<ThemeData>(
  (Ref ref) => AppTheme.light(ref.watch(appSettingsProvider).accentColor),
);

/// Active dark theme data.
final Provider<ThemeData> darkThemeProvider = Provider<ThemeData>(
  (Ref ref) => AppTheme.dark(ref.watch(appSettingsProvider).accentColor),
);
