import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/generated/app_localizations.dart';

export '../../l10n/generated/app_localizations.dart';

/// Locales supported by the application (spec: French, English, Arabic).
const List<Locale> appSupportedLocales = <Locale>[
  Locale('fr'),
  Locale('en'),
  Locale('ar'),
];

/// Convenience access to the generated ARB strings:
/// `context.l10n.shellTabTasks`.
extension AppLocalizationsContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

/// Locale override used by the language selector (step 7); `null` follows the
/// system locale.
final StateProvider<Locale?> appLocaleProvider =
    StateProvider<Locale?>((Ref ref) => null);
