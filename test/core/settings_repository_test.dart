import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskflow/core/settings/app_settings.dart';
import 'package:taskflow/core/settings/settings_repository.dart';
import 'package:taskflow/core/theme/app_colors.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  group('SharedPreferencesSettingsRepository', () {
    test('defaults to the system theme and the blue accent', () async {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      final SettingsRepository repository =
          SharedPreferencesSettingsRepository(preferences);

      final AppSettings settings = repository.read();

      expect(settings.themeMode, AppThemeMode.system);
      expect(settings.accentColor, AppColors.defaultAccent);
      expect(settings.density, AppDensity.comfortable);
      expect(settings.languageCode, isNull);
      expect(settings.textScale, 1);
    });

    test('persists the theme mode, the accent and the density', () async {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      final SettingsRepository repository =
          SharedPreferencesSettingsRepository(preferences);

      await repository.write(
        const AppSettings(
          themeMode: AppThemeMode.dark,
          accentColor: Color(0xFF3FA796),
          density: AppDensity.compact,
          languageCode: 'ar',
          textScale: 1.2,
        ),
      );

      final AppSettings reloaded =
          SharedPreferencesSettingsRepository(preferences).read();
      expect(reloaded.themeMode, AppThemeMode.dark);
      expect(reloaded.accentColor, const Color(0xFF3FA796));
      expect(reloaded.density, AppDensity.compact);
      expect(reloaded.languageCode, 'ar');
      expect(reloaded.textScale, 1.2);
    });

    test('going back to the system language clears the stored code', () async {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      final SettingsRepository repository =
          SharedPreferencesSettingsRepository(preferences);

      await repository.write(const AppSettings(languageCode: 'fr'));
      expect(repository.read().languageCode, 'fr');

      await repository.write(
        repository.read().copyWith(clearLanguage: true),
      );
      final AppSettings reloaded =
          SharedPreferencesSettingsRepository(preferences).read();
      expect(reloaded.languageCode, isNull);
      expect(preferences.getString('settings.languageCode'), isNull);
    });

    test('drops a stored language the application does not speak', () async {
      SharedPreferences.setMockInitialValues(<String, Object>{
        'settings.languageCode': 'de',
      });
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();

      expect(
        SharedPreferencesSettingsRepository(preferences).read().languageCode,
        isNull,
      );
    });

    test('falls back to the defaults on an unknown value', () async {
      SharedPreferences.setMockInitialValues(<String, Object>{
        'settings.themeMode': 'unknown',
        'settings.density': 'unknown',
      });
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();

      final AppSettings settings =
          SharedPreferencesSettingsRepository(preferences).read();

      expect(settings.themeMode, AppThemeMode.system);
      expect(settings.density, AppDensity.comfortable);
      expect(settings.languageCode, isNull);
    });
  });

  group('AppSettings', () {
    test('copyWith keeps the other fields', () {
      const AppSettings settings = AppSettings();
      final AppSettings updated =
          settings.copyWith(themeMode: AppThemeMode.light);

      expect(updated.themeMode, AppThemeMode.light);
      expect(updated.accentColor, settings.accentColor);
      expect(updated, isNot(settings));
    });

    test('copyWith keeps a language when the caller does not touch it', () {
      const AppSettings settings = AppSettings(languageCode: 'ar');
      final AppSettings updated =
          settings.copyWith(density: AppDensity.compact);

      expect(updated.languageCode, 'ar');
      expect(updated, isNot(settings));
    });
  });
}
