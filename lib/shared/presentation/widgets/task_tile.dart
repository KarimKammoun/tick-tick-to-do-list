import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme_extension.dart';
import '../../../features/tasks/domain/task.dart';
import 'task_checkbox.dart';

/// Base task row shared by the mobile list and the desktop list column
/// (Annexe A.5 / C.5): checkbox, title, optional due date and meta line.
class TaskTile extends StatelessWidget {
  const TaskTile({
    required this.task,
    this.subtitle,
    this.isOverdue = false,
    this.onToggle,
    this.onTap,
    super.key,
  });

  final Task task;

  /// Pre-formatted meta line (date, list, tag pills...). Formatting stays in
  /// the feature so that this widget never hard-codes a date format.
  final Widget? subtitle;

  final bool isOverdue;
  final VoidCallback? onToggle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.colors;
    final TextStyle? titleStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
          decoration: task.status == TaskStatus.done
              ? TextDecoration.lineThrough
              : null,
          color: task.status == TaskStatus.done
              ? tokens.textSecondary
              : tokens.textPrimary,
        );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.card,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xxs),
                child: TaskCheckbox(
                  isChecked: task.status == TaskStatus.done,
                  priority: task.priority,
                  onChanged: onToggle == null ? null : (_) => onToggle!(),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(task.title, style: titleStyle),
                    if (subtitle != null) ...<Widget>[
                      const SizedBox(height: AppSpacing.xxs),
                      DefaultTextStyle.merge(
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: isOverdue
                                  ? tokens.danger
                                  : tokens.textSecondary,
                            ),
                        child: subtitle!,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
