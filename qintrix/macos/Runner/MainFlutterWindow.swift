import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  private let initialWindowSize = NSSize(width: 1180, height: 760)
  private var launchCoverView: NSView?

  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let origin = self.frame.origin
    let windowFrame = NSRect(origin: origin, size: initialWindowSize)
    self.backgroundColor = NSColor(
      calibratedRed: 247.0 / 255.0,
      green: 249.0 / 255.0,
      blue: 252.0 / 255.0,
      alpha: 1
    )
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)
    self.minSize = initialWindowSize
    self.maxSize = initialWindowSize
    self.styleMask.remove(.resizable)
    self.collectionBehavior.remove(.fullScreenPrimary)
    self.standardWindowButton(.zoomButton)?.isEnabled = false
    self.standardWindowButton(.zoomButton)?.isHidden = true
    self.center()

    RegisterGeneratedPlugins(registry: flutterViewController)
    configureStartupChannel(flutterViewController)
    showLaunchCover()

    super.awakeFromNib()
  }

  private func configureStartupChannel(_ flutterViewController: FlutterViewController) {
    let channel = FlutterMethodChannel(
      name: "qintrix/startup",
      binaryMessenger: flutterViewController.engine.binaryMessenger
    )

    channel.setMethodCallHandler { [weak self] call, result in
      switch call.method {
      case "ready":
        self?.hideLaunchCover()
        result(nil)
      case "setBackgroundModeEnabled":
        if let enabled = call.arguments as? Bool {
          AppDelegate.backgroundModeEnabled = enabled
          result(nil)
        } else {
          result(
            FlutterError(
              code: "invalid-arguments",
              message: "Expected a boolean background mode flag.",
              details: nil
            )
          )
        }
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }

  private func showLaunchCover() {
    guard let contentView = self.contentView else { return }

    let cover = NSView(frame: contentView.bounds)
    cover.autoresizingMask = [.width, .height]
    cover.wantsLayer = true
    cover.layer?.backgroundColor = NSColor(
      calibratedRed: 247.0 / 255.0,
      green: 249.0 / 255.0,
      blue: 252.0 / 255.0,
      alpha: 1
    ).cgColor

    let stack = NSStackView()
    stack.orientation = .vertical
    stack.alignment = .centerX
    stack.spacing = 18
    stack.translatesAutoresizingMaskIntoConstraints = false

    let icon = NSImageView(image: launchLogoImage())
    icon.translatesAutoresizingMaskIntoConstraints = false
    icon.imageScaling = .scaleProportionallyUpOrDown

    NSLayoutConstraint.activate([
      icon.widthAnchor.constraint(equalToConstant: 104),
      icon.heightAnchor.constraint(equalToConstant: 104)
    ])

    let title = NSTextField(labelWithString: "Qintrix")
    title.font = NSFont.systemFont(ofSize: 30, weight: .bold)
    title.textColor = NSColor(
      calibratedRed: 22.0 / 255.0,
      green: 31.0 / 255.0,
      blue: 61.0 / 255.0,
      alpha: 1
    )

    stack.addArrangedSubview(icon)
    stack.addArrangedSubview(title)
    cover.addSubview(stack)

    NSLayoutConstraint.activate([
      stack.centerXAnchor.constraint(equalTo: cover.centerXAnchor),
      stack.centerYAnchor.constraint(equalTo: cover.centerYAnchor)
    ])

    contentView.addSubview(cover)
    launchCoverView = cover
  }

  private func launchLogoImage() -> NSImage {
    if let privateFrameworksPath = Bundle.main.privateFrameworksPath {
      let flutterAssetPath = privateFrameworksPath
        + "/App.framework/Resources/flutter_assets/assets/logo-trans.png"
      if let image = NSImage(contentsOfFile: flutterAssetPath) {
        return image
      }
    }

    return NSApp.applicationIconImage
  }

  private func hideLaunchCover() {
    guard let cover = launchCoverView else { return }

    NSAnimationContext.runAnimationGroup({ context in
      context.duration = 0.18
      cover.animator().alphaValue = 0
    }, completionHandler: {
      cover.removeFromSuperview()
    })

    launchCoverView = nil
  }
}
