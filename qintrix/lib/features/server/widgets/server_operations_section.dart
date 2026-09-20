import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/data/models/exports.dart';
import 'package:qintrix/features/logs/log_badge_mapper.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

class ServerOperationsSection extends StatelessWidget {
  const ServerOperationsSection({
    required this.settings,
    required this.logs,
    required this.serverError,
    super.key,
  });

  final AppSettingsModel settings;
  final List<AppLogModel> logs;
  final String? serverError;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: theme.cardColor,
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.78)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stacked = constraints.maxWidth < 820;
          final flags = _OperationsFlags(settings: settings);
          final activity = _OperationsActivity(
            title: l10n.dashboardRecentActivityTitle,
            subtitle: l10n.dashboardRecentActivitySubtitle,
            logs: logs,
            emptyLabel: l10n.dashboardRecentActivityEmpty,
          );
          final error = serverError != null && serverError!.trim().isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: _ErrorBox(message: serverError!),
                )
              : const SizedBox.shrink();

          if (stacked) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                flags,
                const SizedBox(height: 14),
                activity,
                error,
              ],
            );
          }

          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: flags),
                ],
              ),
              const SizedBox(height: 14),
              activity,
              error,
            ],
          );
        },
      ),
    );
  }
}

class _OperationsFlags extends StatelessWidget {
  const _OperationsFlags({required this.settings});

  final AppSettingsModel settings;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final items = [
      (
        icon: LucideIcons.play,
        label: l10n.dashboardConfigAutoStart,
        enabled: settings.autoStartServer,
      ),
      (
        icon: LucideIcons.monitorCog,
        label: l10n.dashboardConfigBackgroundMode,
        enabled: settings.enableBackgroundMode,
      ),
      (
        icon: LucideIcons.network,
        label: l10n.dashboardConfigLanAccess,
        enabled: settings.allowLanAccess,
      ),
      (
        icon: LucideIcons.power,
        label: l10n.dashboardConfigStartWithOs,
        enabled: settings.startWithOs,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.dashboardRuntimeTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l10n.dashboardRuntimeSubtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.74),
          ),
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = constraints.maxWidth < 760
                ? double.infinity
                : (constraints.maxWidth - 12) / 2;

            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final item in items)
                  SizedBox(
                    width: cardWidth,
                    child: _RuntimeConfigTile(
                      icon: item.icon,
                      label: item.label,
                      enabled: item.enabled,
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _RuntimeConfigTile extends StatelessWidget {
  const _RuntimeConfigTile({
    required this.icon,
    required this.label,
    required this.enabled,
  });

  final IconData icon;
  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tone = enabled ? AppStatusTone.success : AppStatusTone.info;
    final accent = AppStatusToneColors.resolveForeground(tone);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.68),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: accent.withValues(alpha: 0.12),
            ),
            child: Icon(icon, size: 14, color: accent),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 8),
          StatusBadge(
            label: enabled ? l10n.dashboardEnabled : l10n.dashboardDisabled,
            tone: tone,
            size: StatusBadgeSize.small,
          ),
        ],
      ),
    );
  }
}

class _OperationsActivity extends StatelessWidget {
  const _OperationsActivity({
    required this.title,
    required this.subtitle,
    required this.logs,
    required this.emptyLabel,
  });

  final String title;
  final String subtitle;
  final List<AppLogModel> logs;
  final String emptyLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.74),
          ),
        ),
        const SizedBox(height: 12),
        if (logs.isEmpty)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.28,
              ),
              border: Border.all(
                color: theme.dividerColor.withValues(alpha: 0.7),
              ),
            ),
            child: Text(emptyLabel, style: theme.textTheme.bodyMedium),
          )
        else
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.dividerColor.withValues(alpha: 0.7),
              ),
            ),
            child: Column(
              children: [
                for (var i = 0; i < logs.length; i++)
                  _ActivityItem(log: logs[i], isLast: i == logs.length - 1),
              ],
            ),
          ),
      ],
    );
  }
}

class _ActivityItem extends StatelessWidget {
  const _ActivityItem({required this.log, required this.isLast});

  final AppLogModel log;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tone = LogBadgeMapper.eventTone(log.eventType);
    final accent = AppStatusToneColors.resolveForeground(tone);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(
                  color: theme.dividerColor.withValues(alpha: 0.55),
                ),
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: accent.withValues(alpha: 0.14),
            ),
            child: Icon(
              LogBadgeMapper.eventIcon(log.eventType),
              size: 14,
              color: accent,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  log.title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  log.message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withValues(
                      alpha: 0.8,
                    ),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              StatusBadge(
                label: LogBadgeMapper.humanize(log.eventType),
                tone: tone,
                size: StatusBadgeSize.small,
              ),
              const SizedBox(height: 6),
              Text(
                DateFormat('hh:mm a').format(log.createdAt),
                style: theme.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.textTheme.bodySmall?.color?.withValues(
                    alpha: 0.72,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ErrorBox extends StatelessWidget {
  const _ErrorBox({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: theme.colorScheme.error.withValues(alpha: 0.08),
        border: Border.all(
          color: theme.colorScheme.error.withValues(alpha: 0.24),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            LucideIcons.circleAlert,
            size: 18,
            color: theme.colorScheme.error,
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}
