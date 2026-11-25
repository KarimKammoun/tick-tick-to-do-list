import 'package:flutter/material.dart';

import '../../../../core/localization/localization_providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';

/// Palette of 8 accent colours (Annexe D.3.2), blue being the default.
///
/// The swatch colours come from [AppColors.accentPalette]; nothing here is a
/// screen-level literal.
class AccentColorPicker extends StatelessWidget {
  const AccentColorPicker({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final Color selected;
  final ValueChanged<Color> onChanged;

  String _nameOf(BuildContext context, int index) {
    final AppLocalizations l10n = context.l10n;
    return switch (index) {
      0 => l10n.settingsAccentBlue,
      1 => l10n.settingsAccentTeal,
      2 => l10n.settingsAccentViolet,
      3 => l10n.settingsAccentGreen,
      4 => l10n.settingsAccentAmber,
      5 => l10n.settingsAccentRed,
      6 => l10n.settingsAccentPink,
      _ => l10n.settingsAccentGraphite,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: <Widget>[
        for (int index = 0; index < AppColors.accentPalette.length; index++)
          _AccentSwatch(
            color: AppColors.accentPalette[index],
            label: _nameOf(context, index),
            isSelected:
                AppColors.accentPalette[index].toARGB32() ==
                selected.toARGB32(),
            onTap: () => onChanged(AppColors.accentPalette[index]),
          ),
      ],
    );
  }
}

class _AccentSwatch extends StatelessWidget {
  const _AccentSwatch({
    required this.color,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final Color color;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: Tooltip(
        message: label,
        child: InkResponse(
          onTap: onTap,
          radius: AppSizes.accentSwatch / 2,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            width: AppSizes.accentSwatch,
            height: AppSizes.accentSwatch,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).colorScheme.onSurface
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: isSelected
                ? Icon(Icons.check, size: AppSizes.accentSwatchSelected)
                : null,
          ),
        ),
      ),
    );
  }
}
