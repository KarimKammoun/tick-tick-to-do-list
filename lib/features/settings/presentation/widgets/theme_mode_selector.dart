import 'package:flutter/material.dart';

import '../../../../core/localization/localization_providers.dart';
import '../../../../core/settings/app_settings.dart';

/// Clair / Sombre / Système selector of Annexe D.3.1.
class ThemeModeSelector extends StatelessWidget {
  const ThemeModeSelector({
    required this.value,
    required this.onChanged,
    super.key,
  });

  final AppThemeMode value;
  final ValueChanged<AppThemeMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return SegmentedButton<AppThemeMode>(
      showSelectedIcon: false,
      segments: <ButtonSegment<AppThemeMode>>[
        ButtonSegment<AppThemeMode>(
          value: AppThemeMode.light,
          label: Text(l10n.settingsThemeLight),
          icon: const Icon(Icons.light_mode_outlined),
        ),
        ButtonSegment<AppThemeMode>(
          value: AppThemeMode.dark,
          label: Text(l10n.settingsThemeDark),
          icon: const Icon(Icons.dark_mode_outlined),
        ),
        ButtonSegment<AppThemeMode>(
          value: AppThemeMode.system,
          label: Text(l10n.settingsThemeSystem),
          icon: const Icon(Icons.brightness_auto_outlined),
        ),
      ],
      selected: <AppThemeMode>{value},
      onSelectionChanged: (Set<AppThemeMode> selection) {
        onChanged(selection.first);
      },
    );
  }
}
