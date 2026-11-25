import 'package:flutter/material.dart';

import '../../../core/localization/localization_providers.dart';
import '../../../shared/presentation/widgets/page_scaffold.dart';

/// FocusPage placeholder: the screen arrives in a later step
/// (see docs/PROGRESS.md).
class FocusPage extends StatelessWidget {
  const FocusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: context.l10n.pageFocusTitle,
      body: EmptyStateView(message: context.l10n.placeholderBody),
    );
  }
}
