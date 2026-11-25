import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/l10n/generated/app_localizations.dart';

/// Keys of an ARB file, without the `@@` metadata entries.
Set<String> _keysOf(String path) {
  final Map<String, dynamic> json =
      jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
  return json.keys.where((String key) => !key.startsWith('@')).toSet();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ARB files', () {
    test('French and Arabic translate every English key', () {
      final Set<String> english = _keysOf('lib/l10n/app_en.arb');
      expect(english, isNotEmpty);
      expect(_keysOf('lib/l10n/app_fr.arb'), english);
      expect(_keysOf('lib/l10n/app_ar.arb'), english);
    });

    test('no string is left untranslated in Arabic', () {
      final Map<String, dynamic> english =
          jsonDecode(File('lib/l10n/app_en.arb').readAsStringSync())
              as Map<String, dynamic>;
      final Map<String, dynamic> arabic =
          jsonDecode(File('lib/l10n/app_ar.arb').readAsStringSync())
              as Map<String, dynamic>;

      final List<String> identical = <String>[];
      for (final String key in _keysOf('lib/l10n/app_en.arb')) {
        // The application name stays identical in every language.
        if (key == 'appTitle') {
          continue;
        }
        if (english[key] == arabic[key]) {
          identical.add(key);
        }
      }
      expect(identical, isEmpty);
    });
  });

  group('AppLocalizations', () {
    test('loads the three supported locales', () async {
      for (final Locale locale in <Locale>[
        const Locale('fr'),
        const Locale('en'),
        const Locale('ar'),
      ]) {
        final AppLocalizations localizations =
            await AppLocalizations.delegate.load(locale);
        expect(localizations.appTitle, 'TaskFlow');
        expect(localizations.shellTabTasks, isNotEmpty);
      }
    });

    test('Arabic is a supported locale with its own translations', () async {
      final AppLocalizations arabic =
          await AppLocalizations.delegate.load(const Locale('ar'));
      final AppLocalizations english =
          await AppLocalizations.delegate.load(const Locale('en'));

      expect(arabic.localeName, 'ar');
      expect(arabic.shellTabTasks, isNot(english.shellTabTasks));
    });

    testWidgets('Arabic runs right-to-left inside the application', (
      WidgetTester tester,
    ) async {
      late TextDirection direction;
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('ar'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (BuildContext context) {
              direction = Directionality.of(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(direction, TextDirection.rtl);
    });
  });
}
