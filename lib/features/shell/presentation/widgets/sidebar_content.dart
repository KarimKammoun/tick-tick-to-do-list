import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router.dart';
import '../../../../core/localization/localization_providers.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_theme_extension.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../lists/data/list_providers.dart';
import '../../../lists/domain/task_list.dart';
import '../../../tasks/domain/smart_view.dart';

/// Side menu content, shared by the mobile drawer and the desktop sidebar
/// (Annexe A.4 and C.1): profile header, smart views, lists and settings.
class SidebarContent extends ConsumerWidget {
  const SidebarContent({
    this.onNavigate,
    this.currentLocation = AppRoutes.tasks,
    super.key,
  });

  /// Called after a tap, used by the drawer to close itself.
  final VoidCallback? onNavigate;

  final String currentLocation;

  void _go(BuildContext context, String location) {
    context.go(location);
    onNavigate?.call();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<TaskList>> lists = ref.watch(listsProvider);
    final AppLocalizations l10n = context.l10n;

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      children: <Widget>[
        _ProfileHeader(
          onTap: () => _go(context, AppRoutes.profile),
        ),
        const Divider(),
        _SidebarEntry(
          icon: Icons.inbox_outlined,
          label: l10n.navInbox,
          isSelected: currentLocation == AppRoutes.smartView(SmartView.inbox),
          onTap: () => _go(context, AppRoutes.inbox),
        ),
        _SidebarEntry(
          icon: Icons.today_outlined,
          label: l10n.navToday,
          isSelected: currentLocation == AppRoutes.today,
          onTap: () => _go(context, AppRoutes.today),
        ),
        _SidebarEntry(
          icon: Icons.date_range_outlined,
          label: l10n.navNext7Days,
          isSelected: currentLocation == AppRoutes.next7Days,
          onTap: () => _go(context, AppRoutes.next7Days),
        ),
        _SidebarEntry(
          icon: Icons.check_circle_outline,
          label: l10n.navCompleted,
          isSelected: currentLocation == AppRoutes.completed,
          onTap: () => _go(context, AppRoutes.completed),
        ),
        _SidebarEntry(
          icon: Icons.delete_outline,
          label: l10n.navTrash,
          isSelected: false,
          // Trash arrives with the soft-delete UI; kept as a disabled entry so
          // the sidebar already has its final shape.
          onTap: null,
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.xs,
          ),
          child: Text(
            l10n.navLists.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        lists.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Center(
              child: SizedBox.square(
                dimension: AppSizes.iconSmall,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
          error: (Object error, StackTrace stack) =>
              _SidebarMessage(text: context.l10n.errorGeneric),
          data: (List<TaskList> data) {
            if (data.isEmpty) {
              return _SidebarMessage(text: context.l10n.navNoLists);
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                for (final TaskList list in data)
                  _SidebarEntry(
                    icon: Icons.list_alt_outlined,
                    iconColor: list.color,
                    label: list.name,
                    isSelected: currentLocation == AppRoutes.list(list.id),
                    onTap: () => _go(context, AppRoutes.list(list.id)),
                  ),
              ],
            );
          },
        ),
        const Divider(),
        _SidebarEntry(
          icon: Icons.settings_outlined,
          label: l10n.navSettings,
          isSelected: currentLocation == AppRoutes.settings,
          onTap: () => _go(context, AppRoutes.settings),
        ),
      ],
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: AppSizes.icon,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.person_outline,
                size: AppSizes.icon,
                color: context.colors.textSecondary,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    l10n.navProfile,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    l10n.navPremium,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.workspace_premium_outlined,
              size: AppSizes.iconSmall,
              color: context.colors.premium,
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarEntry extends StatelessWidget {
  const _SidebarEntry({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.iconColor,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onTap != null;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 1,
      ),
      child: ListTile(
        dense: true,
        selected: isSelected,
        enabled: isEnabled,
        onTap: onTap,
        shape: const RoundedRectangleBorder(borderRadius: AppRadius.card),
        leading: Icon(
          icon,
          size: AppSizes.iconSmall,
          color: iconColor ??
              (isSelected
                  ? Theme.of(context).colorScheme.primary
                  : context.colors.textSecondary),
        ),
        title: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : context.colors.textPrimary,
              ),
        ),
      ),
    );
  }
}

class _SidebarMessage extends StatelessWidget {
  const _SidebarMessage({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Text(text, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
