import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/calendar/presentation/calendar_page.dart';
import '../features/focus/presentation/focus_page.dart';
import '../features/matrix/presentation/matrix_page.dart';
import '../features/more/presentation/more_page.dart';
import '../features/settings/presentation/settings_page.dart';
import '../features/shell/presentation/app_shell.dart';
import '../features/tasks/presentation/task_detail_page.dart';
import '../features/tasks/presentation/task_list_page.dart';
import '../features/tasks/domain/smart_view.dart';

/// Route paths, referenced by the shell and the sidebar so that no screen
/// spells a location twice.
abstract final class AppRoutes {
  static const String tasks = '/tasks';
  static const String inbox = '/inbox';
  static const String today = '/today';
  static const String next7Days = '/next7-days';
  static const String completed = '/completed';
  static const String calendar = '/calendar';
  static const String matrix = '/matrix';
  static const String focus = '/focus';
  static const String more = '/more';
  static const String settings = '/settings';
  static const String profile = '/profile';

  static String list(String listId) => '/list/$listId';

  static String task(String taskId) => '/task/$taskId';

  /// Path of a smart view.
  static String smartView(SmartView view) => switch (view) {
        SmartView.inbox => inbox,
        SmartView.today => today,
        SmartView.next7Days => next7Days,
        SmartView.completed => completed,
      };
}

/// Application router: five mobile branches (Tasks, Calendar, Matrix, Focus,
/// More) plus the secondary pages reachable from the side menu.
final Provider<GoRouter> routerProvider = Provider<GoRouter>((Ref ref) {
  return GoRouter(
    initialLocation: AppRoutes.tasks,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.tasks,
                builder: (BuildContext context, GoRouterState state) =>
                    const TaskListPage(smartView: SmartView.all),
              ),
              GoRoute(
                path: AppRoutes.inbox,
                builder: (BuildContext context, GoRouterState state) =>
                    const TaskListPage(smartView: SmartView.inbox),
              ),
              GoRoute(
                path: AppRoutes.today,
                builder: (BuildContext context, GoRouterState state) =>
                    const TaskListPage(smartView: SmartView.today),
              ),
              GoRoute(
                path: AppRoutes.next7Days,
                builder: (BuildContext context, GoRouterState state) =>
                    const TaskListPage(smartView: SmartView.next7Days),
              ),
              GoRoute(
                path: AppRoutes.completed,
                builder: (BuildContext context, GoRouterState state) =>
                    const TaskListPage(smartView: SmartView.completed),
              ),
              GoRoute(
                path: '/list/:listId',
                builder: (BuildContext context, GoRouterState state) =>
                    TaskListPage(listId: state.pathParameters['listId']),
              ),
              GoRoute(
                path: '/task/:taskId',
                builder: (BuildContext context, GoRouterState state) =>
                    TaskDetailPage(taskId: state.pathParameters['taskId']),
              ),
              GoRoute(
                path: AppRoutes.settings,
                builder: (BuildContext context, GoRouterState state) =>
                    const SettingsPage(),
              ),
              GoRoute(
                path: AppRoutes.profile,
                builder: (BuildContext context, GoRouterState state) =>
                    const MorePage(
                  titleKey: MorePageTitle.profile,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.calendar,
                builder: (BuildContext context, GoRouterState state) =>
                    const CalendarPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.matrix,
                builder: (BuildContext context, GoRouterState state) =>
                    const MatrixPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.focus,
                builder: (BuildContext context, GoRouterState state) =>
                    const FocusPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.more,
                builder: (BuildContext context, GoRouterState state) =>
                    const MorePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
