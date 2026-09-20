import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qintrix/app/exports.dart';
import 'package:qintrix/core/widgets/app_shell/animated_sidebar.dart';
import 'package:qintrix/core/widgets/app_shell/app_copyright_footer.dart';
import 'package:qintrix/core/widgets/app_shell/glow_orb.dart';
import 'package:qintrix/core/widgets/app_shell/shell_header.dart';
import 'package:qintrix/features/about/exports.dart';
import 'package:qintrix/features/dashboard/exports.dart';
import 'package:qintrix/features/apps/exports.dart';
import 'package:qintrix/features/jobs/exports.dart';
import 'package:qintrix/features/logs/exports.dart';
import 'package:qintrix/features/printers/exports.dart';
import 'package:qintrix/features/server/exports.dart';
import 'package:qintrix/features/settings/exports.dart';
import 'package:qintrix/theme/tokens/color_tokens.dart';
import 'package:qintrix/theme/tokens/radius_tokens.dart';
import 'package:qintrix/theme/tokens/shadow_tokens.dart';

class AppShell extends StatefulWidget {
  const AppShell({required this.initialDestination, super.key});

  final AppDestination initialDestination;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      context.read<ShellNavigationCubit>().setDestination(
        widget.initialDestination,
      );
    });
  }

  @override
  void didUpdateWidget(covariant AppShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialDestination != widget.initialDestination) {
      context.read<ShellNavigationCubit>().setDestination(
        widget.initialDestination,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocBuilder<ShellNavigationCubit, AppDestination>(
      builder: (context, destination) {
        return Scaffold(
          body: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  theme.scaffoldBackgroundColor,
                  (isDark ? AppColorTokens.darkBackground : theme.cardColor)
                      .withValues(alpha: 1),
                  theme.colorScheme.primary.withValues(
                    alpha: isDark ? 0.018 : 0.024,
                  ),
                  theme.colorScheme.secondary.withValues(
                    alpha: isDark ? 0.012 : 0.018,
                  ),
                ],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -140,
                  left: -100,
                  child: GlowOrb(
                    color: theme.colorScheme.primary.withValues(
                      alpha: isDark ? 0.045 : 0.06,
                    ),
                    size: 220,
                  ),
                ),
                Positioned(
                  right: -120,
                  bottom: -120,
                  child: GlowOrb(
                    color: theme.colorScheme.secondary.withValues(
                      alpha: isDark ? 0.032 : 0.05,
                    ),
                    size: 240,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1180),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const AnimatedSidebar(),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    AppRadiusTokens.xl,
                                  ),
                                  color: theme.cardColor.withValues(
                                    alpha: isDark ? 0.94 : 0.975,
                                  ),
                                  border: Border.all(
                                    color: theme.dividerColor.withValues(
                                      alpha: isDark ? 0.4 : 0.8,
                                    ),
                                  ),
                                  boxShadow: [
                                    ...AppShadowTokens.soft(
                                      isDark
                                          ? Colors.black
                                          : theme.colorScheme.primary,
                                    ),
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: isDark ? 0.1 : 0.025,
                                      ),
                                      blurRadius: 28,
                                      offset: const Offset(0, 12),
                                    ),
                                  ],
                                ),
                                  child: Column(
                                  children: [
                                    ShellHeader(destination: destination),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(16, 2, 16, 8),
                                        child: IndexedStack(
                                          index: destination.index,
                                          children: const [
                                            DashboardPage(),
                                            ServerPage(),
                                            PrintersPage(),
                                            JobsPage(),
                                            AppsPage(),
                                            LogsPage(),
                                            SettingsPage(),
                                            AboutPage(),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                                      child: AppCopyrightFooter(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
