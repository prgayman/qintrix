import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/app/app_constants.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutStoryCard extends StatelessWidget {
  const AboutStoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppSectionCard(
      title: l10n.aboutPurposeTitle,
      subtitle: l10n.aboutPurposeSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.aboutPurposeBody,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.65,
            ),
          ),
          const SizedBox(height: 18),
          const _AboutDivider(),
          const SizedBox(height: 18),
          _AboutMiniInfo(
            icon: LucideIcons.route,
            title: l10n.aboutAudienceTitle,
            description: l10n.aboutAudienceBody,
          ),
        ],
      ),
    );
  }
}

class AboutWorkflowCard extends StatelessWidget {
  const AboutWorkflowCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppSectionCard(
      title: l10n.aboutWorkflowTitle,
      subtitle: l10n.aboutWorkflowSubtitle,
      child: Column(
        children: [
          _AboutStepTile(
            step: '01',
            icon: LucideIcons.plugZap,
            title: l10n.aboutWorkflowStepConnectTitle,
            description: l10n.aboutWorkflowStepConnectDescription,
          ),
          const SizedBox(height: 14),
          _AboutStepTile(
            step: '02',
            icon: LucideIcons.workflow,
            title: l10n.aboutWorkflowStepProcessTitle,
            description: l10n.aboutWorkflowStepProcessDescription,
          ),
          const SizedBox(height: 14),
          _AboutStepTile(
            step: '03',
            icon: LucideIcons.scanSearch,
            title: l10n.aboutWorkflowStepObserveTitle,
            description: l10n.aboutWorkflowStepObserveDescription,
          ),
        ],
      ),
    );
  }
}

class AboutModulesCard extends StatelessWidget {
  const AboutModulesCard({required this.isCompact, super.key});

  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final moduleCards = [
      _AboutModuleCard(
        icon: LucideIcons.server,
        title: l10n.navServer,
        description: l10n.serverDescription,
        color: AppColorTokens.gradientBlueMid,
      ),
      _AboutModuleCard(
        icon: LucideIcons.printer,
        title: l10n.navPrinters,
        description: l10n.printersDescription,
        color: AppColorTokens.gradientOrange,
      ),
      _AboutModuleCard(
        icon: LucideIcons.fileClock,
        title: l10n.navJobs,
        description: l10n.jobsDescription,
        color: AppColorTokens.gradientCyan,
      ),
      _AboutModuleCard(
        icon: LucideIcons.shieldCheck,
        title: l10n.navApps,
        description: l10n.appsDescription,
        color: AppColorTokens.success,
      ),
      _AboutModuleCard(
        icon: LucideIcons.fileText,
        title: l10n.navLogs,
        description: l10n.logsDescription,
        color: AppColorTokens.highlightYellow,
      ),
      _AboutModuleCard(
        icon: LucideIcons.slidersHorizontal,
        title: l10n.navSettings,
        description: l10n.settingsDescription,
        color: AppColorTokens.info,
      ),
    ];

    return AppSectionCard(
      title: l10n.aboutModulesTitle,
      subtitle: l10n.aboutModulesSubtitle,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = isCompact || constraints.maxWidth < 720;
          final cardWidth = compact
              ? double.infinity
              : (constraints.maxWidth - 12) / 2;

          return Wrap(
            spacing: 12,
            runSpacing: 12,
            children: moduleCards
                .map((card) => SizedBox(width: cardWidth, child: card))
                .toList(),
          );
        },
      ),
    );
  }
}

class AboutHighlightsCard extends StatelessWidget {
  const AboutHighlightsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppSectionCard(
      title: l10n.aboutHighlightsTitle,
      subtitle: l10n.aboutHighlightsSubtitle,
      child: Column(
        children: [
          _AboutHighlightTile(
            icon: LucideIcons.lockKeyhole,
            title: l10n.aboutHighlightSecureTitle,
            description: l10n.aboutHighlightSecureDescription,
          ),
          const SizedBox(height: 12),
          _AboutHighlightTile(
            icon: LucideIcons.gauge,
            title: l10n.aboutHighlightReliableTitle,
            description: l10n.aboutHighlightReliableDescription,
          ),
          const SizedBox(height: 12),
          _AboutHighlightTile(
            icon: LucideIcons.blocks,
            title: l10n.aboutHighlightFlexibleTitle,
            description: l10n.aboutHighlightFlexibleDescription,
          ),
        ],
      ),
    );
  }
}

class AboutVersionCard extends StatelessWidget {
  const AboutVersionCard({super.key});

  static final Uri _tenvoroPublisherUri = Uri.parse(
    'https://codecanyon.net/user/tenvoro',
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return AppSectionCard(
      title: l10n.aboutVersionLabel,
      subtitle: l10n.aboutVersionDescription,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: theme.colorScheme.primary.withValues(alpha: 0.06),
          border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppConstants.appVersion,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.aboutVersionNote,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.55),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: theme.colorScheme.surface.withValues(alpha: 0.74),
                border: Border.all(
                  color: theme.dividerColor.withValues(alpha: 0.72),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: AppColorTokens.gradientBlueMid.withValues(
                            alpha: 0.12,
                          ),
                        ),
                        child: const Icon(
                          LucideIcons.badgeCheck,
                          size: 18,
                          color: AppColorTokens.gradientBlueMid,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.aboutAttributionTitle,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              l10n.aboutAttributionSubtitle,
                              style: theme.textTheme.bodySmall?.copyWith(
                                height: 1.45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: OutlinedButton.icon(
                      onPressed: () => launchUrl(
                        _tenvoroPublisherUri,
                        mode: LaunchMode.externalApplication,
                      ),
                      icon: const Icon(LucideIcons.externalLink, size: 16),
                      label: Text(l10n.aboutAttributionAction),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutStepTile extends StatelessWidget {
  const _AboutStepTile({
    required this.step,
    required this.icon,
    required this.title,
    required this.description,
  });

  final String step;
  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: theme.cardColor.withValues(alpha: 0.58),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.7)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
            ),
            child: Text(
              step,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 18, color: theme.colorScheme.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(height: 1.55),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutModuleCard extends StatelessWidget {
  const _AboutModuleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: theme.cardColor.withValues(alpha: 0.58),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.72)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: color.withValues(alpha: 0.12),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(height: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutHighlightTile extends StatelessWidget {
  const _AboutHighlightTile({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: theme.cardColor.withValues(alpha: 0.5),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.72)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: theme.colorScheme.secondary.withValues(alpha: 0.12),
            ),
            child: Icon(icon, size: 18, color: theme.colorScheme.secondary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(height: 1.55),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutMiniInfo extends StatelessWidget {
  const _AboutMiniInfo({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
          ),
          child: Icon(icon, size: 18, color: theme.colorScheme.primary),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(height: 1.55),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AboutDivider extends StatelessWidget {
  const _AboutDivider();

  @override
  Widget build(BuildContext context) {
    return Divider(color: Theme.of(context).dividerColor.withValues(alpha: 0.7));
  }
}
