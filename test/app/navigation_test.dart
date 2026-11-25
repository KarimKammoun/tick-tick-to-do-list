import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskflow/app/router.dart';
import 'package:taskflow/l10n/generated/app_localizations.dart';
import 'package:taskflow/core/database/app_database.dart';
import 'package:taskflow/core/database/database_providers.dart';
import 'package:taskflow/core/settings/app_settings.dart';
import 'package:taskflow/core/settings/settings_providers.dart';
import 'package:taskflow/core/settings/settings_repository.dart';
import 'package:taskflow/features/shell/presentation/app_shell.dart';

import '../data/test_database.dart';

/// Settings kept in memory so the router tests do not touch the disk.
class _MemorySettingsRepository implements SettingsRepository {
  AppSettings _settings = const AppSettings();

  @override
  AppSettings read() => _settings;

  @override
  Future<void> write(AppSettings settings) async => _settings = settings;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase database;

  setUp(() {
    database = openTestDatabase();
    SharedPreferences.setMockInitialValues(<String, Object>{});
  });

  tearDown(() async {
    await database.close();
  });

  Future<GoRouter> pumpRouter(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    late GoRouter router;
    final ProviderContainer container = ProviderContainer(
      overrides: <Override>[
        settingsRepositoryProvider
            .overrideWithValue(_MemorySettingsRepository()),
        appDatabaseProvider.overrideWithValue(database),
      ],
    );
    addTearDown(container.dispose);
    router = container.read(routerProvider);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig: router,
          localizationsDelegates: appLocalizationsDelegates,
          supportedLocales: const <Locale>[Locale('fr'), Locale('en'), Locale('ar')],
          theme: container.read(lightThemeProvider),
          darkTheme: container.read(darkThemeProvider),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return router;
  }

  group('Router', () {
    testWidgets('starts on the tasks branch', (WidgetTester tester) async {
      final GoRouter router = await pumpRouter(tester);

      expect(router.state.uri.path, AppRoutes.tasks);
      expect(find.byType(NavigationRail), findsNothing);
      expect(find.byType(AppShell), findsOneWidget);
    });

    testWidgets('reaches every top-level route', (WidgetTester tester) async {
      final GoRouter router = await pumpRouter(tester);

      for (final String location in <String>[
        AppRoutes.calendar,
        AppRoutes.matrix,
        AppRoutes.focus,
        AppRoutes.more,
        AppRoutes.settings,
        AppRoutes.inbox,
        AppRoutes.today,
        AppRoutes.next7Days,
        AppRoutes.completed,
      ]) {
        router.go(location);
        await tester.pumpAndSettle();
        expect(router.state.uri.path, location, reason: location);
        expect(tester.takeException(), isNull, reason: location);
      }
    });

    testWidgets('opens a list and a task detail by id', (
      WidgetTester tester,
    ) async {
      final GoRouter router = await pumpRouter(tester);

      final String listLocation = AppRoutes.list('list-1');
      router.go(listLocation);
      await tester.pumpAndSettle();
      expect(router.state.uri.path, listLocation);

      final String taskLocation = AppRoutes.task('task-1');
      router.go(taskLocation);
      await tester.pumpAndSettle();
      expect(router.state.uri.path, taskLocation);
    });
  });
}
