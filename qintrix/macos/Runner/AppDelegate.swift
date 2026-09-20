import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
  static var backgroundModeEnabled = false

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return !Self.backgroundModeEnabled
  }

  override func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
    guard !flag else {
      return true
    }

    if let window = sender.windows.first {
      window.makeKeyAndOrderFront(self)
    }
    sender.activate(ignoringOtherApps: true)
    return true
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }
}
