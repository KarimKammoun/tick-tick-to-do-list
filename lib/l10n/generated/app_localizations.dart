// GENERATED CODE - DO NOT MODIFY BY HAND.
//
// Output of `flutter gen-l10n` for lib/l10n/app_*.arb (see l10n.yaml).
// Committed so that the project analyses and builds without running code
// generation first; regenerate with `flutter gen-l10n` after editing an ARB
// file.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// Application name. Not translated, kept in every ARB file.
  ///
  /// In en, this message translates to:
  /// **'TaskFlow'**
  String get appTitle;

  /// Short subtitle under the application name on the splash/placeholder screens.
  ///
  /// In en, this message translates to:
  /// **'Tasks, calendar and focus in one place.'**
  String get appTagline;

  /// Mobile bottom bar, first icon. Icon only on the bar, the string is used as tooltip and for screen readers.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get shellTabTasks;

  /// Mobile bottom bar, second icon.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get shellTabCalendar;

  /// Mobile bottom bar, third icon (Eisenhower matrix).
  ///
  /// In en, this message translates to:
  /// **'Matrix'**
  String get shellTabMatrix;

  /// Mobile bottom bar, fourth icon (Pomodoro).
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get shellTabFocus;

  /// Mobile bottom bar, fifth icon, opens the side menu.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get shellTabMore;

  /// Tooltip of the drawer button.
  ///
  /// In en, this message translates to:
  /// **'Open menu'**
  String get shellOpenMenu;

  /// Semantic label of the drawer close button.
  ///
  /// In en, this message translates to:
  /// **'Close menu'**
  String get shellCloseMenu;

  /// Smart view holding the tasks without a list.
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get navInbox;

  /// Smart view of the tasks due today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get navToday;

  /// Smart view of the tasks due in the coming week.
  ///
  /// In en, this message translates to:
  /// **'Next 7 Days'**
  String get navNext7Days;

  /// Smart view of the finished tasks.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get navCompleted;

  /// Soft deleted tasks, purged after 30 days.
  ///
  /// In en, this message translates to:
  /// **'Trash'**
  String get navTrash;

  /// Sidebar section header above the user lists.
  ///
  /// In en, this message translates to:
  /// **'Lists'**
  String get navLists;

  /// Sidebar section header above the folders.
  ///
  /// In en, this message translates to:
  /// **'Folders'**
  String get navFolders;

  /// Empty state of the sidebar list section.
  ///
  /// In en, this message translates to:
  /// **'No list yet'**
  String get navNoLists;

  /// Sidebar entry opening the settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// Sidebar entry opening the account screen (step 4).
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// Crown badge of the Premium plan.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get navPremium;

  /// Title of the task page placeholder.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get pageTasksTitle;

  /// Title of the calendar page placeholder.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get pageCalendarTitle;

  /// Title of the Eisenhower matrix page placeholder.
  ///
  /// In en, this message translates to:
  /// **'Matrix'**
  String get pageMatrixTitle;

  /// Title of the Pomodoro page placeholder.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get pageFocusTitle;

  /// Title of the secondary menu page placeholder.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get pageMoreTitle;

  /// Title of the settings page.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get pageSettingsTitle;

  /// Title of the Inbox view placeholder.
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get pageInboxTitle;

  /// Title of the Today view placeholder.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get pageTodayTitle;

  /// Title of the Next 7 Days view placeholder.
  ///
  /// In en, this message translates to:
  /// **'Next 7 Days'**
  String get pageNext7DaysTitle;

  /// Title of the Completed view placeholder.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get pageCompletedTitle;

  /// Title of the task detail placeholder.
  ///
  /// In en, this message translates to:
  /// **'Task details'**
  String get pageTaskDetailTitle;

  /// Title of the profile placeholder.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get pageProfileTitle;

  /// Body text of the empty pages created in step 0.
  ///
  /// In en, this message translates to:
  /// **'This screen arrives in a later step.'**
  String get placeholderBody;

  /// Section header of the appearance settings.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearanceSection;

  /// Theme option: always light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// Theme option: always dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// Theme option: follow the operating system. Default.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// Section header of the accent colour picker.
  ///
  /// In en, this message translates to:
  /// **'Accent colour'**
  String get settingsAccentSection;

  /// Name of the default blue accent (#4772FA).
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get settingsAccentBlue;

  /// Name of the turquoise accent (#3FA796).
  ///
  /// In en, this message translates to:
  /// **'Turquoise'**
  String get settingsAccentTeal;

  /// Name of the violet accent.
  ///
  /// In en, this message translates to:
  /// **'Violet'**
  String get settingsAccentViolet;

  /// Name of the green accent.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get settingsAccentGreen;

  /// Name of the amber accent.
  ///
  /// In en, this message translates to:
  /// **'Amber'**
  String get settingsAccentAmber;

  /// Name of the red accent.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get settingsAccentRed;

  /// Name of the pink accent.
  ///
  /// In en, this message translates to:
  /// **'Pink'**
  String get settingsAccentPink;

  /// Name of the neutral graphite accent.
  ///
  /// In en, this message translates to:
  /// **'Graphite'**
  String get settingsAccentGraphite;

  /// Section header of the density setting (Annexe D.3.3).
  ///
  /// In en, this message translates to:
  /// **'Density'**
  String get settingsDensitySection;

  /// Density option with regular spacing.
  ///
  /// In en, this message translates to:
  /// **'Comfortable'**
  String get settingsDensityComfortable;

  /// Density option with tighter spacing.
  ///
  /// In en, this message translates to:
  /// **'Compact'**
  String get settingsDensityCompact;

  /// Section header of the language setting.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageSection;

  /// Language option following the device language.
  ///
  /// In en, this message translates to:
  /// **'System language'**
  String get settingsLanguageSystem;

  /// Language name, written in its own language.
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get settingsLanguageFrench;

  /// Language name, written in its own language.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// Language name, written in its own language.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get settingsLanguageArabic;

  /// Badge shown on settings that are not implemented yet.
  ///
  /// In en, this message translates to:
  /// **'Coming in a later step'**
  String get settingsSoon;

  /// Generic add action.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get commonAdd;

  /// Floating action button tooltip.
  ///
  /// In en, this message translates to:
  /// **'Add task'**
  String get commonAddTask;

  /// Generic cancel action.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// Generic close action.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// Fallback error message.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get errorGeneric;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". '
    'This is likely an issue with the localizations generation tool. Please '
    'file an issue on GitHub with a reproducible sample app and the gen-l10n '
    'configuration that was used.',
  );
}
