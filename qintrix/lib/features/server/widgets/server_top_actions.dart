import 'package:flutter/material.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/l10n/app_localizations.dart';

import '../server_state.dart';

class ServerTopActions extends StatelessWidget {
  const ServerTopActions({
    required this.action,
    required this.onStart,
    required this.onRestart,
    required this.onStop,
    super.key,
  });

  final ServerAction action;
  final VoidCallback? onStart;
  final VoidCallback? onRestart;
  final VoidCallback? onStop;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        AppButton(
          label: l10n.dashboardServerStart,
          leading: LucideIcons.play,
          variant: AppButtonVariant.primary,
          isLoading: action == ServerAction.starting,
          onPressed: onStart,
        ),
        AppButton(
          label: l10n.dashboardServerRestart,
          leading: LucideIcons.rotateCw,
          variant: AppButtonVariant.secondary,
          isLoading: action == ServerAction.restarting,
          onPressed: onRestart,
        ),
        AppButton(
          label: l10n.dashboardServerStop,
          leading: LucideIcons.square,
          variant: AppButtonVariant.secondary,
          isLoading: action == ServerAction.stopping,
          onPressed: onStop,
        ),
      ],
    );
  }
}
