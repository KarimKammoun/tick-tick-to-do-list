import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../app_shell.dart';
import 'shell_destination.dart';

/// Mobile layout: content + bottom bar with five icon-only destinations and a
/// side drawer opened from the first icon's leading button area (Annexe A).
class MobileShell extends StatelessWidget {
  const MobileShell({
    required this.navigationShell,
    required this.onSelectDestination,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final ValueChanged<int> onSelectDestination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppSideDrawer(currentLocation: currentLocationOf(context)),
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: context.colors.divider)),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (int index) {
            if (index == ShellDestination.more.index) {
              Scaffold.of(context).openDrawer();
              return;
            }
            onSelectDestination(index);
          },
          destinations: <Widget>[
            for (final ShellDestination destination in ShellDestination.values)
              NavigationDestination(
                icon: Tooltip(
                  message: destination.localizedLabel(context),
                  child: Icon(destination.icon),
                ),
                selectedIcon: Tooltip(
                  message: destination.localizedLabel(context),
                  child: Icon(destination.selectedIcon),
                ),
                label: destination.localizedLabel(context),
                tooltip: destination.localizedLabel(context),
              ),
          ],
        ),
      ),
    );
  }
}
