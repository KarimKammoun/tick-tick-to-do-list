import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/localization/localization_providers.dart';
import '../core/settings/app_settings.dart';
import '../core/settings/settings_providers.dart';
import 'router.dart';

/// Root widget: localisation, themes and router.
class TaskFlowApp extends ConsumerWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter router = ref.watch(routerProvider);
    final AppSettings settings = ref.watch(appSettingsProvider);
    final Locale? localeOverride = ref.watch(appLocaleProvider);
    final ThemeData lightTheme = ref.watch(lightThemeProvider);
    final ThemeData darkTheme = ref.watch(darkThemeProvider);

    return MaterialApp.router(
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      themeMode: settings.themeMode.materialMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      locale: localeOverride,
      supportedLocales: appSupportedLocales,
      localizationsDelegates: appLocalizationsDelegates,
      localeResolutionCallback: _resolveLocale,
    );
  }

  /// Arabic is used when the device language is Arabic; every other unsupported
  /// language falls back to English, then to the first supported locale.
  Locale _resolveLocale(Locale? locale, Iterable<Locale> supported) {
    if (locale == null) {
      return const Locale('en');
    }
    for (final Locale candidate in supported) {
      if (candidate.languageCode == locale.languageCode) {
        return candidate;
      }
    }
    return const Locale('en');
  }
}

/// Delegates used by the application and by the widget tests: the generated
/// bundle already lists the Material, Cupertino and Widgets delegates.
const List<LocalizationsDelegate<dynamic>> appLocalizationsDelegates =
    AppLocalizations.localizationsDelegates;
