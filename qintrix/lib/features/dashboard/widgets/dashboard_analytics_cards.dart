import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/features/dashboard/models/dashboard_analytics_snapshot.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

class DashboardMetricsGrid extends StatelessWidget {
  const DashboardMetricsGrid({required this.snapshot, super.key});

  final DashboardAnalyticsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final items = [
      _DashboardMetricItem(
        icon: LucideIcons.fileClock,
        label: AppLocalizations.of(context)!.aboutMetricTotalJobs,
        value: snapshot.totalJobs.toString(),
        color: AppColorTokens.gradientBlueMid,
      ),
      _DashboardMetricItem(
        icon: LucideIcons.badgeCheck,
        label: AppLocalizations.of(context)!.aboutMetricCompletionRate,
        value: '${(snapshot.completionRate * 100).round()}%',
        color: AppColorTokens.success,
      ),
      _DashboardMetricItem(
        icon: LucideIcons.printerCheck,
        label: AppLocalizations.of(context)!.aboutMetricEnabledPrinters,
        value: '${snapshot.enabledPrinters}/${snapshot.totalPrinters}',
        color: AppColorTokens.gradientOrange,
      ),
      _DashboardMetricItem(
        icon: LucideIcons.shieldCheck,
        label: AppLocalizations.of(context)!.aboutMetricEnabledApps,
        value: '${snapshot.enabledApps}/${snapshot.totalApps}',
        color: AppColorTokens.info,
      ),
      _DashboardMetricItem(
        icon: LucideIcons.rows3,
        label: AppLocalizations.of(context)!.aboutMetricQueuedJobs,
        value: snapshot.queuedJobs.toString(),
        color: AppColorTokens.highlightYellow,
      ),
      _DashboardMetricItem(
        icon: LucideIcons.triangleAlert,
        label: AppLocalizations.of(context)!.aboutMetricRecentAlerts,
        value: snapshot.totalAlerts.toString(),
        color: AppColorTokens.error,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = switch (constraints.maxWidth) {
          < 640 => 1,
          _ => 2,
        };

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: crossAxisCount == 1 ? 4.8 : 6.2,
          ),
          itemBuilder: (context, index) =>
              _DashboardMetricCard(item: items[index]),
        );
      },
    );
  }
}

class DashboardJobsTrendCard extends StatelessWidget {
  const DashboardJobsTrendCard({required this.snapshot, super.key});

  final DashboardAnalyticsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final dayFormatter = DateFormat('E', localeTag);
    final maxValue = snapshot.dailyJobs.fold<int>(
      0,
      (max, point) => math.max(max, point.value),
    );
    final total = snapshot.dailyJobs.fold<int>(
      0,
      (sum, point) => sum + point.value,
    );
    final peak = snapshot.dailyJobs.fold<DashboardTrendPoint?>(
      null,
      (best, point) => best == null || point.value > best.value ? point : best,
    );

    return AppSectionCard(
      title: l10n.aboutTrendTitle,
      subtitle: l10n.aboutTrendSubtitle,
      leading: _DashboardCardIcon(
        icon: LucideIcons.chartColumn,
        color: AppColorTokens.gradientBlueMid,
      ),
      child: SizedBox(
        height: 280,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _TrendSummaryChip(
                    label: l10n.dashboardTrendTotalLabel,
                    value: '$total',
                    color: AppColorTokens.gradientBlueMid,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _TrendSummaryChip(
                    label: l10n.dashboardTrendPeakDayLabel,
                    value: peak == null
                        ? '-'
                        : '${dayFormatter.format(peak.day)} · ${peak.value}',
                    color: AppColorTokens.gradientCyan,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: snapshot.dailyJobs
                    .map(
                      (point) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(999),
                                  color: theme.colorScheme.surface.withValues(
                                    alpha: 0.74,
                                  ),
                                  border: Border.all(
                                    color: theme.dividerColor.withValues(
                                      alpha: 0.65,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  point.value.toString(),
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: 24,
                                    height: maxValue == 0
                                        ? 16
                                        : (point.value / maxValue) * 82 + 14,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: AppColorTokens.gradientBlueMid,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                dayFormatter.format(point.day),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardDoughnutCard extends StatelessWidget {
  const DashboardDoughnutCard({
    required this.title,
    required this.subtitle,
    required this.headerIcon,
    required this.items,
    required this.labelBuilder,
    required this.colorBuilder,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData headerIcon;
  final List<DashboardBreakdownValue> items;
  final String Function(String key) labelBuilder;
  final Color Function(String key) colorBuilder;

  @override
  Widget build(BuildContext context) {
    return _DashboardOverviewDoughnutCard(
      title: title,
      subtitle: subtitle,
      headerIcon: headerIcon,
      items: items,
      labelBuilder: labelBuilder,
      colorBuilder: colorBuilder,
    );
  }
}

class _TrendSummaryChip extends StatelessWidget {
  const _TrendSummaryChip({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: color.withValues(alpha: 0.08),
        border: Border.all(color: color.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.72),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _OverviewLegendItem extends StatelessWidget {
  const _OverviewLegendItem({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '($value)',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.66),
          ),
        ),
      ],
    );
  }
}

class _DashboardCardIcon extends StatelessWidget {
  const _DashboardCardIcon({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: color.withValues(alpha: 0.12),
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }
}

class _DoughnutChartPainter extends CustomPainter {
  const _DoughnutChartPainter({
    required this.items,
    required this.colorBuilder,
    this.strokeWidth = 18,
  });

  final List<DashboardBreakdownValue> items;
  final Color Function(String key) colorBuilder;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final rect = Rect.fromCircle(center: center, radius: size.width / 2);
    final backgroundPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.04)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawArc(rect, 0, math.pi * 2, false, backgroundPaint);

    var startAngle = -math.pi / 2;
    for (final item in items) {
      if (item.share <= 0) {
        continue;
      }
      final sweepAngle = math.pi * 2 * item.share;
      final paint = Paint()
        ..color = colorBuilder(item.key)
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = strokeWidth;
      canvas.drawArc(
        rect.deflate(strokeWidth / 2),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _DoughnutChartPainter oldDelegate) {
    return oldDelegate.items != items || oldDelegate.strokeWidth != strokeWidth;
  }
}

class DashboardBreakdownCard extends StatelessWidget {
  const DashboardBreakdownCard({
    required this.title,
    required this.subtitle,
    required this.headerIcon,
    required this.items,
    required this.labelBuilder,
    required this.colorBuilder,
    super.key,
  });

  final String title;
  final String subtitle;
  final IconData headerIcon;
  final List<DashboardBreakdownValue> items;
  final String Function(String key) labelBuilder;
  final Color Function(String key) colorBuilder;

  @override
  Widget build(BuildContext context) {
    return _DashboardOverviewDoughnutCard(
      title: title,
      subtitle: subtitle,
      headerIcon: headerIcon,
      items: items,
      labelBuilder: labelBuilder,
      colorBuilder: colorBuilder,
    );
  }
}

class _DashboardOverviewDoughnutCard extends StatelessWidget {
  const _DashboardOverviewDoughnutCard({
    required this.title,
    required this.subtitle,
    required this.headerIcon,
    required this.items,
    required this.labelBuilder,
    required this.colorBuilder,
  });

  final String title;
  final String subtitle;
  final IconData headerIcon;
  final List<DashboardBreakdownValue> items;
  final String Function(String key) labelBuilder;
  final Color Function(String key) colorBuilder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = items.fold<int>(0, (sum, item) => sum + item.value);
    return AppSectionCard(
      title: title,
      subtitle: subtitle,
      leading: _DashboardCardIcon(
        icon: headerIcon,
        color: items.isEmpty
            ? theme.colorScheme.primary
            : colorBuilder(items.first.key),
      ),
      child: SizedBox(
        height: 280,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 178,
                  height: 178,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: const Size.square(178),
                        painter: _DoughnutChartPainter(
                          items: items,
                          colorBuilder: colorBuilder,
                          strokeWidth: 20,
                        ),
                      ),
                      Container(
                        width: 94,
                        height: 94,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.surface,
                          border: Border.all(
                            color: theme.dividerColor.withValues(alpha: 0.65),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$total',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.dashboardTrendTotalLabel,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.textTheme.bodySmall?.color
                                    ?.withValues(alpha: 0.64),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: items
                  .map(
                    (item) => _OverviewLegendItem(
                      label: labelBuilder(item.key),
                      value: item.value,
                      color: colorBuilder(item.key),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardMetricItem {
  const _DashboardMetricItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;
}

class _DashboardMetricCard extends StatelessWidget {
  const _DashboardMetricCard({required this.item});

  final _DashboardMetricItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.cardColor.withValues(alpha: 0.62),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.72)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: item.color.withValues(alpha: 0.12),
                ),
                child: Icon(item.icon, color: item.color, size: 13),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.value,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
