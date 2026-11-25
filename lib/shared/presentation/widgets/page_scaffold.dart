import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme_extension.dart';

/// Standard page container: title, optional actions, optional trailing sliver
/// body. Every screen of the following steps uses it so paddings and titles
/// stay identical everywhere.
class PageScaffold extends StatelessWidget {
  const PageScaffold({
    required this.title,
    required this.body,
    this.actions = const <Widget>[],
    this.floatingActionButton,
    this.showAppBar = true,
    super.key,
  });

  final String title;
  final Widget body;
  final List<Widget> actions;
  final Widget? floatingActionButton;

  /// False inside the desktop shell, where the sidebar already gives context.
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      floatingActionButton: floatingActionButton,
      appBar: showAppBar
          ? AppBar(
              title: Text(title),
              actions: actions,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Divider(color: context.colors.divider, height: 1),
              ),
            )
          : null,
      body: SafeArea(child: body),
    );
  }
}

/// Empty state used by the placeholder pages of step 0 and, later, by the
/// genuinely empty views. Texts come from the ARB files only.
class EmptyStateView extends StatelessWidget {
  const EmptyStateView({
    required this.message,
    this.icon = Icons.inbox_outlined,
    super.key,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              icon,
              size: AppSizes.emptyStateIcon,
              color: context.colors.textSecondary,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
