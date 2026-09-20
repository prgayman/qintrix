import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:qintrix/core/widgets/exports.dart';
import 'package:qintrix/features/dashboard/exports.dart';
import 'package:qintrix/features/startup/exports.dart';
import 'package:qintrix/l10n/app_localizations.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const routeName = '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const MethodChannel _startupChannel = MethodChannel('qintrix/startup');
  bool _didNotifyReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didNotifyReady) {
      return;
    }
    _didNotifyReady = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await _startupChannel.invokeMethod<void>('ready');
      } on MissingPluginException {
        // Non-macOS platforms do not register this startup channel.
      } on PlatformException {
        // Ignore startup-cover teardown failures and continue into Flutter.
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<StartupCubit, StartupState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == StartupStatus.ready) {
          Navigator.of(context).pushReplacementNamed(DashboardPage.routeName);
        }
      },
      child: Scaffold(
        body: Center(
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.92, end: 1),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/logo-trans.png',
                  width: 104,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      LucideIcons.printer,
                      size: 104,
                      color: Theme.of(context).colorScheme.primary,
                    );
                  },
                ),
                const SizedBox(height: 18),
                Text(
                  'Qintrix',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).textTheme.headlineMedium?.color,
                  ),
                ),
                const SizedBox(height: 24),
                BlocBuilder<StartupCubit, StartupState>(
                  builder: (context, state) {
                    if (state.status == StartupStatus.failure) {
                      return AppErrorState(
                        title: l10n.splashErrorTitle,
                        description:
                            state.message ?? l10n.splashErrorDescription,
                        action: AppButton(
                          label: l10n.retry,
                          onPressed: () => context.read<StartupCubit>().start(),
                        ),
                      );
                    }

                    return AppLoadingView(label: l10n.splashLoading);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
