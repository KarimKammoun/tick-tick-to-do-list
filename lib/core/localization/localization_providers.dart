import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';

export '../../l10n/generated/app_localizations.dart';

/// Delegates of the material, cupertino and widgets bundles, taken from the
/// generated class so that the application and the tests share one list.
const List<LocalizationsDelegate<dynamic>> appLocalizationsDelegates =
    AppLocalizations.localizationsDelegates;

/// Locales supported by the application (spec: French, English, Arabic),
/// taken from the generated bundle so that the two lists cannot diverge.
const List<Locale> appSupportedLocales = AppLocalizations.supportedLocales;

/// Convenience access to the generated ARB strings:
/// `context.l10n.shellTabTasks`.
extension AppLocalizationsContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
