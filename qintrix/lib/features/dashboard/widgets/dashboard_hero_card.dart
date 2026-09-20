import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/features/dashboard/models/dashboard_analytics_snapshot.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

class DashboardHeroCard extends StatelessWidget {
  const DashboardHeroCard({
    required this.isCompact,
    required this.snapshot,
    super.key,
  });

  final bool isCompact;
  final DashboardAnalyticsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColorTokens.gradientBlueStart.withValues(
              alpha: isDark ? 0.92 : 0.96,
            ),
            AppColorTokens.gradientBlueMid.withValues(
              alpha: isDark ? 0.96 : 0.92,
            ),
            AppColorTokens.gradientCyan.withValues(
              alpha: isDark ? 0.78 : 0.82,
            ),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -22,
            right: -8,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            bottom: -34,
            left: -18,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColorTokens.highlightYellow.withValues(alpha: 0.13),
              ),
            ),
          ),
          if (isCompact)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _DashboardHeroLead(snapshot: snapshot),
                const SizedBox(height: 18),
                _DashboardHeroCopy(snapshot: snapshot, isCompact: true),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 5, child: _DashboardHeroLead(snapshot: snapshot)),
                const SizedBox(width: 28),
                Expanded(
                  flex: 6,
                  child: _DashboardHeroCopy(snapshot: snapshot, isCompact: false),
                ),
              ],
            ),
          if (!isCompact)
            Positioned(
              top: 0,
              right: 0,
              child: StatusBadge(
                label: snapshot.serverState.isRunning
                    ? l10n.dashboardServerRunning
                    : l10n.dashboardServerStopped,
                tone: snapshot.serverState.isRunning
                    ? AppStatusTone.success
                    : AppStatusTone.warning,
                size: StatusBadgeSize.small,
              ),
            ),
        ],
      ),
    );
  }
}

class _DashboardHeroLead extends StatelessWidget {
  const _DashboardHeroLead({required this.snapshot});

  final DashboardAnalyticsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: Colors.white.withValues(alpha: 0.14),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          ),
          child: Text(
            l10n.navDashboard,
            style: theme.textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          l10n.aboutAnalyticsTitle,
          style: theme.textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            height: 1,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          l10n.dashboardDescription,
          style: theme.textTheme.titleMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.92),
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

class _DashboardHeroCopy extends StatelessWidget {
  const _DashboardHeroCopy({required this.snapshot, required this.isCompact});

  final DashboardAnalyticsSnapshot snapshot;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            StatusBadge(
              label: snapshot.serverState.isRunning
                  ? l10n.dashboardServerRunning
                  : l10n.dashboardServerStopped,
              tone: snapshot.serverState.isRunning
                  ? AppStatusTone.success
                  : AppStatusTone.warning,
              size: StatusBadgeSize.small,
            ),
            const _DashboardHeroPill(
              icon: LucideIcons.chartColumnBig,
              label: 'Analytics',
            ),
            const _DashboardHeroPill(
              icon: LucideIcons.fileClock,
              label: 'Queue',
            ),
            const _DashboardHeroPill(
              icon: LucideIcons.printer,
              label: 'Devices',
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          l10n.aboutAnalyticsSubtitle,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.white.withValues(alpha: 0.9),
            height: 1.55,
          ),
        ),
      ],
    );
  }
}

class _DashboardHeroPill extends StatelessWidget {
  const _DashboardHeroPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Colors.white.withValues(alpha: 0.12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
