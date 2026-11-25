import 'package:flutter/material.dart';

import '../../../../app/router.dart';
import '../../../../core/localization/localization_providers.dart';

/// The five entries of the mobile bottom bar (Annexe A: icons only, no text)
/// and of the desktop icon rail (Annexe C.1).
enum ShellDestination {
  tasks(
    route: AppRoutes.tasks,
    icon: Icons.check_circle_outline,
    selectedIcon: Icons.check_circle,
    label: _ShellLabel.tasks,
  ),
  calendar(
    route: AppRoutes.calendar,
    icon: Icons.calendar_today_outlined,
    selectedIcon: Icons.calendar_today,
    label: _ShellLabel.calendar,
  ),
  matrix(
    route: AppRoutes.matrix,
    icon: Icons.grid_view_outlined,
    selectedIcon: Icons.grid_view_rounded,
    label: _ShellLabel.matrix,
  ),
  focus(
    route: AppRoutes.focus,
    icon: Icons.timer_outlined,
    selectedIcon: Icons.timer,
    label: _ShellLabel.focus,
  ),
  more(
    route: AppRoutes.more,
    icon: Icons.more_horiz,
    selectedIcon: Icons.more_horiz,
    label: _ShellLabel.more,
  );

  const ShellDestination({
    required this.route,
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final String route;
  final IconData icon;
  final IconData selectedIcon;
  final _ShellLabel label;

  /// Localised name, also used as tooltip and semantic label because the bar
  /// shows icons only.
  String localizedLabel(BuildContext context) => switch (label) {
        _ShellLabel.tasks => context.l10n.shellTabTasks,
        _ShellLabel.calendar => context.l10n.shellTabCalendar,
        _ShellLabel.matrix => context.l10n.shellTabMatrix,
        _ShellLabel.focus => context.l10n.shellTabFocus,
        _ShellLabel.more => context.l10n.shellTabMore,
      };
}

/// Indirection so that the enum stays const while the strings stay in the ARB
/// files.
enum _ShellLabel { tasks, calendar, matrix, focus, more }
