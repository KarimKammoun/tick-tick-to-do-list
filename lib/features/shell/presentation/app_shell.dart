import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_spacing.dart';
import 'widgets/desktop_shell.dart';
import 'widgets/mobile_shell.dart';
import 'widgets/sidebar_content.dart';

/// Responsive application shell (step 0, point 5).
///
/// * `< 700 px` (mobile): bottom bar with five icon-only destinations and a
///   side drawer.
/// * `700 .. 1000 px` (tablet): icon rail plus a persistent sidebar.
/// * `> 1000 px` (desktop): the four zones of Annexe C.1 - icon rail, sidebar,
///   list column and a detail panel.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  /// Opens a branch, or pops back to its root when it is already selected.
  void _onSelect(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double width = constraints.maxWidth;

        if (width < AppBreakpoints.mobile) {
          return MobileShell(
            navigationShell: navigationShell,
            onSelectDestination: (int index) => _onSelect(context, index),
          );
        }

        if (width < AppBreakpoints.desktop) {
          return DesktopShell(
            navigationShell: navigationShell,
            onSelectDestination: (int index) => _onSelect(context, index),
            hasDetailPanel: false,
          );
        }

        return DesktopShell(
          navigationShell: navigationShell,
          onSelectDestination: (int index) => _onSelect(context, index),
          hasDetailPanel: true,
        );
      },
    );
  }
}

/// Drawer used by the mobile layout; kept here so that both layouts build the
/// same menu.
class AppSideDrawer extends StatelessWidget {
  const AppSideDrawer({required this.currentLocation, super.key});

  final String currentLocation;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: AppSizes.sidebarWidth,
      child: SafeArea(
        child: SidebarContent(
          currentLocation: currentLocation,
          onNavigate: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
    );
  }
}

/// Route location of the current shell, used to highlight the active entry.
String currentLocationOf(BuildContext context) {
  final GoRouter router = GoRouter.of(context);
  return router.routerDelegate.currentConfiguration.uri.toString();
}
