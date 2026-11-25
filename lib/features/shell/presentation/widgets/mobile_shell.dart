import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme_extension.dart';
import '../app_shell.dart';
import 'shell_destination.dart';

/// Mobile layout: content + bottom bar with five icon-only destinations and a
/// side drawer (Annexe A: the five icons carry no text).
class MobileShell extends StatefulWidget {
  const MobileShell({
    required this.navigationShell,
    required this.onSelectDestination,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final ValueChanged<int> onSelectDestination;

  @override
  State<MobileShell> createState() => _MobileShellState();
}

class _MobileShellState extends State<MobileShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppSideDrawer(currentLocation: currentLocationOf(context)),
      body: widget.navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: context.colors.divider)),
        ),
        child: NavigationBar(
          selectedIndex: widget.navigationShell.currentIndex,
          onDestinationSelected: (int index) {
            // The fifth destination opens the side menu: it has no other entry
            // point on mobile (Annexe A.4).
            if (index == ShellDestination.more.index) {
              _scaffoldKey.currentState?.openDrawer();
              return;
            }
            widget.onSelectDestination(index);
          },
          destinations: <Widget>[
            for (final ShellDestination destination in ShellDestination.values)
              NavigationDestination(
                icon: Icon(destination.icon),
                selectedIcon: Icon(destination.selectedIcon),
                label: destination.localizedLabel(context),
                tooltip: destination.localizedLabel(context),
              ),
          ],
        ),
      ),
    );
  }
}
