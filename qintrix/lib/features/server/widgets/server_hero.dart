import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

class ServerHero extends StatelessWidget {
  const ServerHero({
    required this.title,
    required this.subtitle,
    required this.statusLabel,
    required this.runtimeTitle,
    required this.runtimeValue,
    required this.startedLabel,
    required this.changedLabel,
    required this.hostValue,
    required this.portValue,
    required this.isRunning,
    super.key,
  });

  final String title;
  final String subtitle;
  final String statusLabel;
  final String runtimeTitle;
  final String runtimeValue;
  final String startedLabel;
  final String changedLabel;
  final String hostValue;
  final String portValue;
  final bool isRunning;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColorTokens.gradientBlueStart,
            AppColorTokens.gradientBlueMid,
            AppColorTokens.gradientCyan,
          ],
        ),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            top: -18,
            end: -14,
            child: Container(
              width: 132,
              height: 132,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColorTokens.gradientYellow.withValues(alpha: 0.16),
              ),
            ),
          ),
          PositionedDirectional(
            bottom: -44,
            start: -24,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColorTokens.gradientOrange.withValues(alpha: 0.16),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeroHeading(
                title: title,
                subtitle: subtitle,
                statusLabel: statusLabel,
                isRunning: isRunning,
              ),
              const SizedBox(height: 14),
              _HeroSummary(
                runtimeTitle: runtimeTitle,
                runtimeValue: runtimeValue,
                startedLabel: startedLabel,
                changedLabel: changedLabel,
                hostValue: hostValue,
                portValue: portValue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroHeading extends StatelessWidget {
  const _HeroHeading({
    required this.title,
    required this.subtitle,
    required this.statusLabel,
    required this.isRunning,
  });

  final String title;
  final String subtitle;
  final String statusLabel;
  final bool isRunning;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.86),
          ),
        ),
        const SizedBox(height: 10),
        StatusBadge(
          label: statusLabel,
          tone: isRunning ? AppStatusTone.success : AppStatusTone.warning,
          size: StatusBadgeSize.small,
        ),
      ],
    );
  }
}

class _HeroSummary extends StatelessWidget {
  const _HeroSummary({
    required this.runtimeTitle,
    required this.runtimeValue,
    required this.startedLabel,
    required this.changedLabel,
    required this.hostValue,
    required this.portValue,
  });

  final String runtimeTitle;
  final String runtimeValue;
  final String startedLabel;
  final String changedLabel;
  final String hostValue;
  final String portValue;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final stacked = constraints.maxWidth < 760;
        final metaGrid = Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _MetaStrip(
                    icon: LucideIcons.server,
                    label: AppLocalizations.of(context)!.dashboardMetricHost,
                    value: hostValue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MetaStrip(
                    icon: LucideIcons.waypoints,
                    label: AppLocalizations.of(context)!.dashboardMetricPort,
                    value: portValue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _MetaStrip(
                    icon: LucideIcons.clock3,
                    label: AppLocalizations.of(context)!.dashboardMetricStartedAt,
                    value: startedLabel,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MetaStrip(
                    icon: LucideIcons.activity,
                    label: AppLocalizations.of(context)!.dashboardMetricLastChanged,
                    value: changedLabel,
                  ),
                ),
              ],
            ),
          ],
        );

        if (stacked) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _RuntimeOrb(
                runtimeTitle: runtimeTitle,
                runtimeValue: runtimeValue,
              ),
              const SizedBox(height: 18),
              metaGrid,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _RuntimeOrb(runtimeTitle: runtimeTitle, runtimeValue: runtimeValue),
            const SizedBox(width: 14),
            Expanded(child: metaGrid),
          ],
        );
      },
    );
  }
}

class _RuntimeOrb extends StatelessWidget {
  const _RuntimeOrb({required this.runtimeTitle, required this.runtimeValue});

  final String runtimeTitle;
  final String runtimeValue;

  @override
  Widget build(BuildContext context) {
    final accent = AppColorTokens.gradientYellow;

    return SizedBox(
      width: 164,
      height: 164,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 164,
            height: 164,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.16),
                width: 1.5,
              ),
            ),
          ),
          Transform.rotate(
            angle: math.pi / 9,
            child: Container(
              width: 132,
              height: 132,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: accent.withValues(alpha: 0.46),
                  width: 2,
                ),
              ),
            ),
          ),
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.13),
            ),
          ),
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.18),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                runtimeTitle,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.78),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                runtimeValue,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.4,
                ),
              ),
            ],
          ),
          Positioned(top: 18, right: 24, child: _Dot(color: accent)),
          Positioned(
            bottom: 22,
            left: 18,
            child: _Dot(color: Colors.white.withValues(alpha: 0.88)),
          ),
        ],
      ),
    );
  }
}

class _MetaStrip extends StatelessWidget {
  const _MetaStrip({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withValues(alpha: 0.12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 15, color: Colors.white.withValues(alpha: 0.9)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}
