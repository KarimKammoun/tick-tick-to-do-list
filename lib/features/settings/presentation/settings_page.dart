import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/localization/localization_providers.dart';
import '../../../core/settings/app_settings.dart';
import '../../../core/settings/settings_providers.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_theme_extension.dart';
import '../../../shared/presentation/widgets/app_card.dart';
import '../../../shared/presentation/widgets/page_scaffold.dart';
import 'widgets/accent_color_picker.dart';
import 'widgets/theme_mode_selector.dart';

/// Settings > Appearance (Annexe D.3).
///
/// Step 0 implements the theme choice (Clair / Sombre / Système), the accent
/// colour, the density and the language. All four are persisted locally, so the
/// choice survives a restart.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppSettings settings = ref.watch(appSettingsProvider);
    final AppSettingsController controller =
        ref.read(appSettingsProvider.notifier);
    final AppLocalizations l10n = context.l10n;

    return PageScaffold(
      title: l10n.pageSettingsTitle,
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: <Widget>[
          _SectionTitle(text: l10n.settingsAppearanceSection),
          AppCard(
            child: ThemeModeSelector(
              value: settings.themeMode,
              onChanged: controller.setThemeMode,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionTitle(text: l10n.settingsAccentSection),
          AppCard(
            child: AccentColorPicker(
              selected: settings.accentColor,
              onChanged: controller.setAccentColor,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionTitle(text: l10n.settingsDensitySection),
          AppCard(
            child: SegmentedButton<AppDensity>(
              showSelectedIcon: false,
              segments: <ButtonSegment<AppDensity>>[
                ButtonSegment<AppDensity>(
                  value: AppDensity.comfortable,
                  label: Text(l10n.settingsDensityComfortable),
                  icon: const Icon(Icons.view_agenda_outlined),
                ),
                ButtonSegment<AppDensity>(
                  value: AppDensity.compact,
                  label: Text(l10n.settingsDensityCompact),
                  icon: const Icon(Icons.view_headline_outlined),
                ),
              ],
              selected: <AppDensity>{settings.density},
              onSelectionChanged: (Set<AppDensity> selection) {
                controller.setDensity(selection.first);
              },
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _SectionTitle(text: l10n.settingsLanguageSection),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _LanguageTile(
                  label: l10n.settingsLanguageSystem,
                  isSelected: settings.languageCode == null,
                  onTap: () => controller.setLanguage(null),
                ),
                _LanguageTile(
                  label: l10n.settingsLanguageFrench,
                  isSelected: settings.languageCode == 'fr',
                  onTap: () => controller.setLanguage('fr'),
                ),
                _LanguageTile(
                  label: l10n.settingsLanguageEnglish,
                  isSelected: settings.languageCode == 'en',
                  onTap: () => controller.setLanguage('en'),
                ),
                _LanguageTile(
                  label: l10n.settingsLanguageArabic,
                  isSelected: settings.languageCode == 'ar',
                  onTap: () => controller.setLanguage('ar'),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.xs,
        bottom: AppSpacing.sm,
      ),
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: context.colors.textSecondary),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(label),
      selected: isSelected,
      onTap: onTap,
      trailing: isSelected
          ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
          : null,
    );
  }
}
