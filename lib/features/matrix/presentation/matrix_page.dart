import 'package:flutter/material.dart';

import '../../../core/localization/localization_providers.dart';
import '../../../shared/presentation/widgets/page_scaffold.dart';

/// MatrixPage placeholder: the screen arrives in a later step (see docs/PROGRESS.md).
class MatrixPage extends StatelessWidget {
  const MatrixPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: context.l10n.pageMatrixTitle,
      body: EmptyStateView(message: context.l10n.placeholderBody),
    );
  }
}
