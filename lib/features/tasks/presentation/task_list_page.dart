import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/localization_providers.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/presentation/widgets/add_task_button.dart';
import '../../../shared/presentation/widgets/page_scaffold.dart';
import '../../lists/data/list_providers.dart';
import '../../lists/domain/task_list.dart';
import '../domain/smart_view.dart';

/// Task list page.
///
/// Step 0 ships the shell only: the page already resolves the active view and
/// its title, but creating, editing and completing tasks belongs to step 1, so
/// the body is a placeholder and the "+" button opens a placeholder sheet.
class TaskListPage extends ConsumerWidget {
  const TaskListPage({this.listId, this.smartView = SmartView.all, super.key});

  /// Identifier of the displayed list; `null` means the Inbox.
  final String? listId;

  /// Predefined view, used for the page title.
  final SmartView smartView;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageScaffold(
      title: _title(context, ref),
      floatingActionButton: AddTaskButton(
        onPressed: () => _showQuickAddSheet(context),
      ),
      body: EmptyStateView(
        icon: Icons.playlist_add_check,
        message: context.l10n.placeholderBody,
      ),
    );
  }

  String _title(BuildContext context, WidgetRef ref) {
    return switch (smartView) {
      SmartView.today => context.l10n.pageTodayTitle,
      SmartView.next7Days => context.l10n.pageNext7DaysTitle,
      SmartView.completed => context.l10n.pageCompletedTitle,
      SmartView.inbox => context.l10n.pageInboxTitle,
      SmartView.all => _listName(ref) ?? context.l10n.pageTasksTitle,
    };
  }

  /// Name of the list opened through `/list/:listId`.
  String? _listName(WidgetRef ref) {
    final String? wanted = listId;
    if (wanted == null) {
      return null;
    }
    final List<TaskList> lists = ref.watch(listsProvider).value ??
        const <TaskList>[];
    for (final TaskList list in lists) {
      if (list.id == wanted) {
        return list.name;
      }
    }
    return null;
  }

  /// Placeholder of the quick-add sheet. Step 0 only needs the rounded sheet
  /// component to exist; the real form is built in step 2.
  void _showQuickAddSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      shape: Theme.of(context).bottomSheetTheme.shape,
      barrierColor: Theme.of(context).bottomSheetTheme.barrierColor,
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  sheetContext.l10n.commonAddTask,
                  style: Theme.of(sheetContext).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  sheetContext.l10n.placeholderBody,
                  style: Theme.of(sheetContext).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
