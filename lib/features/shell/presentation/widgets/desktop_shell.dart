import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/localization/localization_providers.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../app_shell.dart';
import 'shell_destination.dart';
import 'sidebar_content.dart';

/// Desktop layout of Annexe C.1: four zones.
///
/// 1. the icon rail (with the accent tinted background),
/// 2. the sidebar holding the smart views and the lists,
/// 3. the content column (the active branch),
/// 4. the detail panel, shown from 1000 px up.
class DesktopShell extends StatelessWidget {
  const DesktopShell({
    required this.navigationShell,
    required this.onSelectDestination,
    required this.hasDetailPanel,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final ValueChanged<int> onSelectDestination;

  /// False between 700 and 1000 px, where the detail panel is dropped.
  final bool hasDetailPanel;

  @override
  Widget build(BuildContext context) {
    final String location = currentLocationOf(context);
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    final Widget rail = _IconRail(
      currentIndex: navigationShell.currentIndex,
      onSelect: onSelectDestination,
    );
    final Widget sidebar = ColoredBox(
      color: context.colors.surfaceSidebar,
      child: SidebarContent(currentLocation: location),
    );
    final Widget content = ColoredBox(
      color: context.colors.background,
      child: navigationShell,
    );
    final Widget detail = ColoredBox(
      color: context.colors.surface,
      child: _DetailPanel(),
    );

    final List<Widget> zones = <Widget>[
      SizedBox(width: AppSizes.railWidth, child: rail),
      SizedBox(width: AppSizes.sidebarWidth, child: sidebar),
      Expanded(child: content),
      if (hasDetailPanel)
        SizedBox(width: AppSizes.detailPanelWidth, child: detail),
    ];

    return Scaffold(
      body: Row(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        children: zones,
      ),
    );
  }
}

class _IconRail extends StatelessWidget {
  const _IconRail({required this.currentIndex, required this.onSelect});

  final int currentIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppLocalizations l10n = context.l10n;

    return ColoredBox(
      color: colors.rail,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: AppSpacing.md),
            for (final ShellDestination destination in ShellDestination.values)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                child: Tooltip(
                  message: destination.localizedLabel(context),
                  child: InkResponse(
                    onTap: () => onSelect(destination.index),
                    radius: AppSizes.icon,
                    child: SizedBox.square(
                      dimension: AppSizes.icon + AppSpacing.md,
                      child: Icon(
                        destination.index == currentIndex
                            ? destination.selectedIcon
                            : destination.icon,
                        size: AppSizes.icon,
                        color: destination.index == currentIndex
                            ? colors.onRail
                            : colors.onRail.withValues(alpha: 0.65),
                      ),
                    ),
                  ),
                ),
              ),
            const Spacer(),
            Tooltip(
              message: l10n.navSettings,
              child: InkResponse(
                onTap: () => context.go(AppRoutes.settings),
                radius: AppSizes.icon,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Icon(
                    Icons.settings_outlined,
                    size: AppSizes.icon,
                    color: colors.onRail.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Zone 4 of Annexe C.1. In step 0 no task is selected yet, so the panel shows
/// its empty state; step 2 fills it with the task detail form.
class _DetailPanel extends StatelessWidget {
  const _DetailPanel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              context.l10n.pageTaskDetailTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              context.l10n.placeholderBody,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
