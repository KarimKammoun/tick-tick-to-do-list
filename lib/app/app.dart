import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/localization/localization_providers.dart';
import '../core/settings/app_settings.dart';
import '../core/settings/settings_providers.dart';
import '../l10n/generated/app_localizations.dart';
import 'router.dart';

/// Root widget: localisation, themes and router.
class TaskFlowApp extends ConsumerWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter router = ref.watch(routerProvider);
    final AppSettings settings = ref.watch(appSettingsProvider);
    final Locale? localeOverride = ref.watch(appLocaleProvider);

    return MaterialApp.router(
      onGenerateTitle: (BuildContext context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      themeMode: settings.themeMode.materialMode,
      theme: ref.watch(lightThemeProvider),
      darkTheme: ref.watch(darkThemeProvider),
      locale: localeOverride,
      supportedLocales: appSupportedLocales,
      localizationsDelegates: appLocalizationsDelegates,
      localeResolutionCallback: _resolveLocale,
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: TextScaler.linear(
              mediaQuery.textScaler.scale(1) * settings.textScale,
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
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

/// Exposes the Flutter delegates to the tests and to the ARB generation.
const List<LocalizationsDelegate<Object>> appLocalizationsDelegates =
    <LocalizationsDelegate<Object>>[
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
