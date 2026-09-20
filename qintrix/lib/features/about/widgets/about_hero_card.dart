import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/app/app_constants.dart';
import 'package:qintrix/l10n/app_localizations.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';

class AboutHeroCard extends StatelessWidget {
  const AboutHeroCard({required this.isCompact, super.key});

  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
            AppColorTokens.gradientCyan.withValues(alpha: isDark ? 0.78 : 0.82),
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
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AboutHeroLead(),
                SizedBox(height: 18),
                _AboutHeroCopy(isCompact: true),
              ],
            )
          else
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 5, child: _AboutHeroLead()),
                SizedBox(width: 28),
                Expanded(flex: 6, child: _AboutHeroCopy(isCompact: false)),
              ],
            ),
        ],
      ),
    );
  }
}

class _AboutHeroLead extends StatelessWidget {
  const _AboutHeroLead();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                color: Colors.white.withValues(alpha: 0.16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Image.asset('assets/logo-trans.png'),
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppConstants.appName,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.aboutHeading,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.92),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AboutHeroCopy extends StatelessWidget {
  const _AboutHeroCopy({required this.isCompact});

  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.aboutDescription,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.white.withValues(alpha: 0.92),
            height: 1.55,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _AboutHeroPill(
              icon: LucideIcons.server,
              label: l10n.aboutHeroPillLocalBridge,
            ),
            _AboutHeroPill(
              icon: LucideIcons.shieldCheck,
              label: l10n.aboutHeroPillSecureApps,
            ),
            _AboutHeroPill(
              icon: LucideIcons.badgeCheck,
              label: l10n.aboutHeroPillOperationalControl,
            ),
          ],
        ),
        if (!isCompact) ...[
          const SizedBox(height: 22),
          Text(
            l10n.aboutAudienceBody,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.82),
              height: 1.55,
            ),
          ),
        ],
      ],
    );
  }
}

class _AboutHeroPill extends StatelessWidget {
  const _AboutHeroPill({required this.icon, required this.label});

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
