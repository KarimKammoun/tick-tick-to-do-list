import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskflow/app/app.dart';
import 'package:taskflow/core/database/app_database.dart';
import 'package:taskflow/core/database/database_providers.dart';
import 'package:taskflow/core/settings/app_settings.dart';
import 'package:taskflow/core/settings/settings_providers.dart';
import 'package:taskflow/core/settings/settings_repository.dart';
import 'package:taskflow/core/theme/app_colors.dart';
import 'package:taskflow/core/theme/app_theme_extension.dart';

import '../data/test_database.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase database;

  setUp(() {
    database = openTestDatabase();
  });

  tearDown(() async {
    await database.close();
  });

  /// Pumps the whole application on an in-memory database and resets the
  /// appearance settings between tests.
  Future<void> pumpApp(WidgetTester tester, Size window) async {
    tester.view.physicalSize = window;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    SharedPreferences.setMockInitialValues(<String, Object>{});
    final SharedPreferences preferences =
        await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          settingsRepositoryProvider.overrideWithValue(
            SharedPreferencesSettingsRepository(preferences),
          ),
          appDatabaseProvider.overrideWithValue(database),
        ],
        child: const TaskFlowApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('Shell', () {
    testWidgets('mobile layout shows five icon-only destinations', (
      WidgetTester tester,
    ) async {
      await pumpApp(tester, const Size(400, 800));

      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byType(NavigationDestination), findsNWidgets(5));
      // Annexe A: the bottom bar carries icons only, never text.
      expect(
        Theme.of(tester.element(find.byType(NavigationBar)))
            .navigationBarTheme
            .labelBehavior,
        NavigationDestinationLabelBehavior.alwaysHide,
      );
    });

    testWidgets('the fifth destination opens the side menu', (
      WidgetTester tester,
    ) async {
      await pumpApp(tester, const Size(400, 800));

      await tester.tap(find.byIcon(Icons.more_horiz).first);
      await tester.pumpAndSettle();

      expect(find.byType(Drawer), findsOneWidget);
      expect(find.text('Settings'), findsWidgets);
      expect(find.text('Inbox'), findsWidgets);
    });

    testWidgets('desktop layout uses the four zones above 1000 px', (
      WidgetTester tester,
    ) async {
      await pumpApp(tester, const Size(1400, 900));

      expect(find.byType(NavigationBar), findsNothing);
      // Zone 2 (sidebar) and zone 4 (detail panel) are both visible.
      expect(find.text('Inbox'), findsWidgets);
      expect(find.text('Task details'), findsOneWidget);
    });

    testWidgets('tablet layout keeps the rail but drops the detail panel', (
      WidgetTester tester,
    ) async {
      await pumpApp(tester, const Size(800, 900));

      expect(find.byType(NavigationBar), findsNothing);
      expect(find.text('Task details'), findsNothing);
      expect(find.text('Inbox'), findsWidgets);
    });

    testWidgets('navigates to the calendar branch', (WidgetTester tester) async {
      await pumpApp(tester, const Size(400, 800));

      await tester.tap(find.byIcon(Icons.calendar_today_outlined).first);
      await tester.pumpAndSettle();

      expect(find.text('Calendar'), findsWidgets);
    });
  });

  group('Appearance settings', () {
    testWidgets('switching to dark mode applies the dark tokens', (
      WidgetTester tester,
    ) async {
      await pumpApp(tester, const Size(500, 1000));

      final ProviderContainer container = ProviderScope.containerOf(
        tester.element(find.byType(NavigationBar)),
        listen: false,
      );
      await container
          .read(appSettingsProvider.notifier)
          .setThemeMode(AppThemeMode.dark);
      await tester.pumpAndSettle();

      final ThemeData theme =
          Theme.of(tester.element(find.byType(NavigationBar)));
      expect(theme.brightness, Brightness.dark);
      expect(
        theme.extension<AppColorsTheme>()!.colors.background,
        AppColors.dark().background,
      );
    });

    testWidgets('the accent colour drives the primary colour', (
      WidgetTester tester,
    ) async {
      await pumpApp(tester, const Size(500, 1000));

      final ProviderContainer container = ProviderScope.containerOf(
        tester.element(find.byType(NavigationBar)),
        listen: false,
      );
      await container
          .read(appSettingsProvider.notifier)
          .setAccentColor(const Color(0xFF3FA796));
      await tester.pumpAndSettle();

      final ThemeData theme =
          Theme.of(tester.element(find.byType(NavigationBar)));
      expect(theme.colorScheme.primary, isNot(AppColors.defaultAccent));
      expect(
        theme.extension<AppColorsTheme>()!.colors.accentedColor,
        theme.colorScheme.primary,
      );
    });
  });
}
