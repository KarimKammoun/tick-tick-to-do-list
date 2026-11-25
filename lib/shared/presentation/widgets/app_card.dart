import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme_extension.dart';

/// White (light) or dark-surface card of Annexe D.2, with the standard radius
/// and padding. Screens must use it instead of styling a `Container` by hand.
class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.onTap,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Widget content = Padding(padding: padding, child: child);
    return Material(
      color: context.colors.surface,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.card),
      clipBehavior: Clip.antiAlias,
      child: onTap == null ? content : InkWell(onTap: onTap, child: content),
    );
  }
}
