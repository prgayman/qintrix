class AppLaunchMode {
  const AppLaunchMode._({required this.isBackgroundLaunch});

  const AppLaunchMode.standard() : this._(isBackgroundLaunch: false);

  const AppLaunchMode.background() : this._(isBackgroundLaunch: true);

  static const backgroundLaunchArgument = '--background-launch';

  final bool isBackgroundLaunch;

  factory AppLaunchMode.fromArgs(List<String> args) {
    return args.contains(backgroundLaunchArgument)
        ? const AppLaunchMode.background()
        : const AppLaunchMode.standard();
  }
}
