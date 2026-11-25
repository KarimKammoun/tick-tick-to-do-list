import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';

/// Floating "+" button shared by the list pages (Annexe A.5).
///
/// Step 0 only exposes the button; the quick-add sheet is built in step 2.
class AddTaskButton extends StatelessWidget {
  const AddTaskButton({this.onPressed, super.key});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: context.l10n.commonAddTask,
      elevation: 2,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.card),
      child: const Icon(Icons.add, size: AppSizes.icon),
    );
  }
}
