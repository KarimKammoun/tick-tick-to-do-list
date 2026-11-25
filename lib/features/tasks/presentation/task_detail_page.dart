import 'package:flutter/material.dart';

import '../../../core/localization/localization_providers.dart';
import '../../../shared/presentation/widgets/page_scaffold.dart';

/// Task detail placeholder (Annexe B.1 mobile sheet, Annexe C.8 desktop panel).
/// The form itself is built in step 2.
class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({required this.taskId, super.key});

  final String? taskId;

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: context.l10n.pageTaskDetailTitle,
      body: EmptyStateView(
        icon: Icons.task_alt,
        message: context.l10n.placeholderBody,
      ),
    );
  }
}
