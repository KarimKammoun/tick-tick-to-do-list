// GENERATED CODE - DO NOT MODIFY BY HAND.
//
// Mirrors the output of `flutter gen-l10n` for lib/l10n/app_*.arb (see
// l10n.yaml) and merged into this single committed file so that `flutter analyze`
// and `flutter test` work without running code generation first.
// Regenerate with `flutter gen-l10n` after editing an ARB file.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

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

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'TaskFlow';

  @override
  String get appTagline => 'Tasks, calendar and focus in one place.';

  @override
  String get shellTabTasks => 'Tasks';

  @override
  String get shellTabCalendar => 'Calendar';

  @override
  String get shellTabMatrix => 'Matrix';

  @override
  String get shellTabFocus => 'Focus';

  @override
  String get shellTabMore => 'More';

  @override
  String get shellOpenMenu => 'Open menu';

  @override
  String get shellCloseMenu => 'Close menu';

  @override
  String get navInbox => 'Inbox';

  @override
  String get navToday => 'Today';

  @override
  String get navNext7Days => 'Next 7 Days';

  @override
  String get navCompleted => 'Completed';

  @override
  String get navTrash => 'Trash';

  @override
  String get navLists => 'Lists';

  @override
  String get navFolders => 'Folders';

  @override
  String get navNoLists => 'No list yet';

  @override
  String get navSettings => 'Settings';

  @override
  String get navProfile => 'Profile';

  @override
  String get navPremium => 'Premium';

  @override
  String get pageTasksTitle => 'Tasks';

  @override
  String get pageCalendarTitle => 'Calendar';

  @override
  String get pageMatrixTitle => 'Matrix';

  @override
  String get pageFocusTitle => 'Focus';

  @override
  String get pageMoreTitle => 'More';

  @override
  String get pageSettingsTitle => 'Settings';

  @override
  String get pageInboxTitle => 'Inbox';

  @override
  String get pageTodayTitle => 'Today';

  @override
  String get pageNext7DaysTitle => 'Next 7 Days';

  @override
  String get pageCompletedTitle => 'Completed';

  @override
  String get pageTaskDetailTitle => 'Task details';

  @override
  String get pageProfileTitle => 'Profile';

  @override
  String get placeholderBody => 'This screen arrives in a later step.';

  @override
  String get settingsAppearanceSection => 'Appearance';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsAccentSection => 'Accent colour';

  @override
  String get settingsAccentBlue => 'Blue';

  @override
  String get settingsAccentTeal => 'Turquoise';

  @override
  String get settingsAccentViolet => 'Violet';

  @override
  String get settingsAccentGreen => 'Green';

  @override
  String get settingsAccentAmber => 'Amber';

  @override
  String get settingsAccentRed => 'Red';

  @override
  String get settingsAccentPink => 'Pink';

  @override
  String get settingsAccentGraphite => 'Graphite';

  @override
  String get settingsDensitySection => 'Density';

  @override
  String get settingsDensityComfortable => 'Comfortable';

  @override
  String get settingsDensityCompact => 'Compact';

  @override
  String get settingsLanguageSection => 'Language';

  @override
  String get settingsLanguageSystem => 'System language';

  @override
  String get settingsLanguageFrench => 'Français';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageArabic => 'العربية';

  @override
  String get settingsSoon => 'Coming in a later step';

  @override
  String get commonAdd => 'Add';

  @override
  String get commonAddTask => 'Add task';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonClose => 'Close';

  @override
  String get errorGeneric => 'Something went wrong.';
}

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'TaskFlow';

  @override
  String get appTagline => 'Tâches, calendrier et concentration au même endroit.';

  @override
  String get shellTabTasks => 'Tâches';

  @override
  String get shellTabCalendar => 'Calendrier';

  @override
  String get shellTabMatrix => 'Matrice';

  @override
  String get shellTabFocus => 'Concentration';

  @override
  String get shellTabMore => 'Plus';

  @override
  String get shellOpenMenu => 'Ouvrir le menu';

  @override
  String get shellCloseMenu => 'Fermer le menu';

  @override
  String get navInbox => 'Boîte de réception';

  @override
  String get navToday => 'Aujourd\'hui';

  @override
  String get navNext7Days => '7 prochains jours';

  @override
  String get navCompleted => 'Terminées';

  @override
  String get navTrash => 'Corbeille';

  @override
  String get navLists => 'Listes';

  @override
  String get navFolders => 'Dossiers';

  @override
  String get navNoLists => 'Aucune liste';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get navProfile => 'Profil';

  @override
  String get navPremium => 'Premium';

  @override
  String get pageTasksTitle => 'Tâches';

  @override
  String get pageCalendarTitle => 'Calendrier';

  @override
  String get pageMatrixTitle => 'Matrice';

  @override
  String get pageFocusTitle => 'Concentration';

  @override
  String get pageMoreTitle => 'Plus';

  @override
  String get pageSettingsTitle => 'Paramètres';

  @override
  String get pageInboxTitle => 'Boîte de réception';

  @override
  String get pageTodayTitle => 'Aujourd\'hui';

  @override
  String get pageNext7DaysTitle => '7 prochains jours';

  @override
  String get pageCompletedTitle => 'Terminées';

  @override
  String get pageTaskDetailTitle => 'Détails de la tâche';

  @override
  String get pageProfileTitle => 'Profil';

  @override
  String get placeholderBody => 'Cet écran arrive dans une étape ultérieure.';

  @override
  String get settingsAppearanceSection => 'Apparence';

  @override
  String get settingsThemeLight => 'Clair';

  @override
  String get settingsThemeDark => 'Sombre';

  @override
  String get settingsThemeSystem => 'Système';

  @override
  String get settingsAccentSection => 'Couleur d\'accentuation';

  @override
  String get settingsAccentBlue => 'Bleu';

  @override
  String get settingsAccentTeal => 'Turquoise';

  @override
  String get settingsAccentViolet => 'Violet';

  @override
  String get settingsAccentGreen => 'Vert';

  @override
  String get settingsAccentAmber => 'Ambre';

  @override
  String get settingsAccentRed => 'Rouge';

  @override
  String get settingsAccentPink => 'Rose';

  @override
  String get settingsAccentGraphite => 'Graphite';

  @override
  String get settingsDensitySection => 'Densité';

  @override
  String get settingsDensityComfortable => 'Confortable';

  @override
  String get settingsDensityCompact => 'Compact';

  @override
  String get settingsLanguageSection => 'Langue';

  @override
  String get settingsLanguageSystem => 'Langue du système';

  @override
  String get settingsLanguageFrench => 'Français';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageArabic => 'العربية';

  @override
  String get settingsSoon => 'Disponible dans une étape ultérieure';

  @override
  String get commonAdd => 'Ajouter';

  @override
  String get commonAddTask => 'Ajouter une tâche';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonClose => 'Fermer';

  @override
  String get errorGeneric => 'Une erreur est survenue.';
}

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'TaskFlow';

  @override
  String get appTagline => 'المهام والتقويم والتركيز في مكان واحد.';

  @override
  String get shellTabTasks => 'المهام';

  @override
  String get shellTabCalendar => 'التقويم';

  @override
  String get shellTabMatrix => 'المصفوفة';

  @override
  String get shellTabFocus => 'التركيز';

  @override
  String get shellTabMore => 'المزيد';

  @override
  String get shellOpenMenu => 'فتح القائمة';

  @override
  String get shellCloseMenu => 'إغلاق القائمة';

  @override
  String get navInbox => 'صندوق الوارد';

  @override
  String get navToday => 'اليوم';

  @override
  String get navNext7Days => 'الأيام السبعة القادمة';

  @override
  String get navCompleted => 'المكتملة';

  @override
  String get navTrash => 'المهملات';

  @override
  String get navLists => 'القوائم';

  @override
  String get navFolders => 'المجلدات';

  @override
  String get navNoLists => 'لا توجد قائمة';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get navPremium => 'بريميوم';

  @override
  String get pageTasksTitle => 'المهام';

  @override
  String get pageCalendarTitle => 'التقويم';

  @override
  String get pageMatrixTitle => 'المصفوفة';

  @override
  String get pageFocusTitle => 'التركيز';

  @override
  String get pageMoreTitle => 'المزيد';

  @override
  String get pageSettingsTitle => 'الإعدادات';

  @override
  String get pageInboxTitle => 'صندوق الوارد';

  @override
  String get pageTodayTitle => 'اليوم';

  @override
  String get pageNext7DaysTitle => 'الأيام السبعة القادمة';

  @override
  String get pageCompletedTitle => 'المكتملة';

  @override
  String get pageTaskDetailTitle => 'تفاصيل المهمة';

  @override
  String get pageProfileTitle => 'الملف الشخصي';

  @override
  String get placeholderBody => 'ستظهر هذه الشاشة في مرحلة لاحقة.';

  @override
  String get settingsAppearanceSection => 'المظهر';

  @override
  String get settingsThemeLight => 'فاتح';

  @override
  String get settingsThemeDark => 'داكن';

  @override
  String get settingsThemeSystem => 'النظام';

  @override
  String get settingsAccentSection => 'لون التمييز';

  @override
  String get settingsAccentBlue => 'أزرق';

  @override
  String get settingsAccentTeal => 'فيروزي';

  @override
  String get settingsAccentViolet => 'بنفسجي';

  @override
  String get settingsAccentGreen => 'أخضر';

  @override
  String get settingsAccentAmber => 'كهرماني';

  @override
  String get settingsAccentRed => 'أحمر';

  @override
  String get settingsAccentPink => 'وردي';

  @override
  String get settingsAccentGraphite => 'فحمي';

  @override
  String get settingsDensitySection => 'الكثافة';

  @override
  String get settingsDensityComfortable => 'مريح';

  @override
  String get settingsDensityCompact => 'مضغوط';

  @override
  String get settingsLanguageSection => 'اللغة';

  @override
  String get settingsLanguageSystem => 'لغة النظام';

  @override
  String get settingsLanguageFrench => 'Français';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageArabic => 'العربية';

  @override
  String get settingsSoon => 'يتوفر في مرحلة لاحقة';

  @override
  String get commonAdd => 'إضافة';

  @override
  String get commonAddTask => 'إضافة مهمة';

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonClose => 'إغلاق';

  @override
  String get errorGeneric => 'حدث خطأ ما.';
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
