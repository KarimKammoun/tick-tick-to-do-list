import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router.dart';
import '../../../core/localization/localization_providers.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../shared/presentation/widgets/app_card.dart';
import '../../../shared/presentation/widgets/page_scaffold.dart';

/// Title variants of [MorePage], which also renders the profile page while
/// step 4 does not exist.
enum MorePageTitle { more, profile }

/// Secondary menu ("Plus") of the mobile bottom bar: entries that do not fit in
/// the bar itself. The settings screen is already reachable here; habits,
/// statistics and widgets arrive in steps 6 and 7.
class MorePage extends StatelessWidget {
  const MorePage({this.titleKey = MorePageTitle.more, super.key});

  final MorePageTitle titleKey;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final bool isProfile = titleKey == MorePageTitle.profile;

    return PageScaffold(
      title: isProfile ? l10n.pageProfileTitle : l10n.pageMoreTitle,
      body: ListView(
        padding: AppSpacing.screenPadding,
        children: <Widget>[
          if (isProfile)
            AppCard(
              child: Text(
                l10n.placeholderBody,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )
          else ...<Widget>[
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: Text(l10n.navSettings),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.go(AppRoutes.settings),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: Text(l10n.navProfile),
                    subtitle: Text(l10n.settingsSoon),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.go(AppRoutes.profile),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
