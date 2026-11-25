import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskflow/app/app.dart';
import 'package:taskflow/core/database/app_database.dart';
import 'package:taskflow/core/database/database_connection_memory.dart';
import 'package:taskflow/core/database/database_providers.dart';
import 'package:taskflow/core/settings/app_settings.dart';
import 'package:taskflow/core/settings/settings_providers.dart';
import 'package:taskflow/core/settings/settings_repository.dart';
import 'package:taskflow/core/theme/app_colors.dart';
import 'package:taskflow/core/theme/app_theme_extension.dart';

import '../data/test_database.dart';

/// The widget tests use the same in-memory database helper as the data tests;
/// the provider override below is what the app talks to.
final AppDatabase _database = openTestDatabase();

Future<void> _pumpApp(WidgetTester tester) async {
  SharedPreferences.setMockInitialValues(<String, Object>{});
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        settingsRepositoryProvider.overrideWithValue(
          SharedPreferencesSettingsRepository(preferences),
        ),
        databaseConnectionProvider.overrideWithValue(
          const InMemoryDatabaseConnection(),
        ),
        appDatabaseProvider.overrideWithValue(_database),
      ],
      child: const TaskFlowApp(),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Shell', () {
    testWidgets('mobile layout shows five icon-only destinations', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _pumpApp(tester);

      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byType(NavigationDestination), findsNWidgets(5));
      // Icon-only bar: the labels are hidden by the theme.
      expect(
        Theme.of(tester.element(find.byType(NavigationBar)))
            .navigationBarTheme
            .labelBehavior,
        NavigationDestinationLabelBehavior.alwaysHide,
      );
    });

    testWidgets('the drawer opens from the More destination', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _pumpApp(tester);
      await tester.tap(find.byIcon(Icons.more_horiz).first);
      await tester.pumpAndSettle();

      expect(find.byType(Drawer), findsOneWidget);
      expect(find.text('Settings'), findsWidgets);
    });

    testWidgets('desktop layout exposes the four zones above 1000 px', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1400, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _pumpApp(tester);

      expect(find.byType(NavigationBar), findsNothing);
      // Rail, sidebar and detail panel are present next to the content.
      expect(find.text('Inbox'), findsWidgets);
      expect(find.text('Task details'), findsOneWidget);
    });

    testWidgets('navigates to the calendar branch', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _pumpApp(tester);
      await tester.tap(find.byIcon(Icons.calendar_today_outlined).first);
      await tester.pumpAndSettle();

      expect(find.text('Calendar'), findsWidgets);
    });
  });

  group('Settings', () {
    testWidgets('switching the theme applies the dark tokens', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(500, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _pumpApp(tester);
      final BuildContext context = tester.element(find.byType(NavigationBar));
      final ProviderContainer container = ProviderScope.containerOf(context);

      await container
          .read(appSettingsProvider.notifier)
          .setThemeMode(AppThemeMode.dark);
      await tester.pumpAndSettle();

      expect(
        container.read(appSettingsProvider).themeMode,
        AppThemeMode.dark,
      );
      final ThemeData theme = Theme.of(
        tester.element(find.byType(NavigationBar)),
      );
      expect(theme.brightness, Brightness.dark);
      expect(
        theme.extension<AppColorsTheme>()!.colors.background,
        AppColors.dark().background,
      );
    });

    testWidgets('the accent colour is applied to the primary colour', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(500, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await _pumpApp(tester);
      final BuildContext context = tester.element(find.byType(NavigationBar));
      final ProviderContainer container = ProviderScope.containerOf(context);

      await container
          .read(appSettingsProvider.notifier)
          .setAccentColor(const Color(0xFF3FA796));
      await tester.pumpAndSettle();

      final ThemeData theme = Theme.of(
        tester.element(find.byType(NavigationBar)),
      );
      expect(theme.colorScheme.primary, isNot(AppColors.defaultAccent));
      expect(
        theme.extension<AppColorsTheme>()!.colors.accentedColor,
        theme.colorScheme.primary,
      );
    });
  });
}
