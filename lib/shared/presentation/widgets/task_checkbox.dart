import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme_extension.dart';
import '../../../features/tasks/domain/task_priority.dart';

/// Square, slightly rounded checkbox of Annexe A.5.
///
/// The border colour carries the priority (spec 5.2): grey none, blue low,
/// amber medium, red high. The colour always comes from the theme tokens, so
/// the two themes stay consistent without any screen-level literal.
class TaskCheckbox extends StatelessWidget {
  const TaskCheckbox({
    required this.isChecked,
    this.priority = TaskPriority.none,
    this.onChanged,
    super.key,
  });

  final bool isChecked;
  final TaskPriority priority;
  final ValueChanged<bool>? onChanged;

  Color _borderColor(BuildContext context) {
    final tokens = context.colors;
    return switch (priority) {
      TaskPriority.none => tokens.priorityNone,
      TaskPriority.low => tokens.priorityLow,
      TaskPriority.medium => tokens.priorityMedium,
      TaskPriority.high => tokens.priorityHigh,
    };
  }

  @override
  Widget build(BuildContext context) {
    final Color border = _borderColor(context);
    final Color fill = isChecked ? border : context.colors.surface;

    return Semantics(
      checked: isChecked,
      child: InkResponse(
        onTap: onChanged == null ? null : () => onChanged!(!isChecked),
        radius: AppSizes.checkboxSize,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          width: AppSizes.checkboxSize,
          height: AppSizes.checkboxSize,
          decoration: BoxDecoration(
            color: fill,
            borderRadius: AppRadius.checkbox,
            border: Border.all(color: border, width: 1.6),
          ),
          child: isChecked
              ? Icon(
                  Icons.check,
                  size: AppSizes.checkboxSize - 6,
                  color: context.colors.surface,
                )
              : null,
        ),
      ),
    );
  }
}
