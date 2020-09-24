import SwiftUI

public extension PreviewDevice {
  /// Whether this code is running in a SwiftUI preview.
  static var inXcode: Bool {
    ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
  }
}
