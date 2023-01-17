#if !(os(macOS) || os(watchOS))
import UIKit

public extension UIAlertAction {
  static var `default`: UIAlertAction {
    UIAlertAction(
      title: "OK",
      style: .default
    )
  }
}
#endif
