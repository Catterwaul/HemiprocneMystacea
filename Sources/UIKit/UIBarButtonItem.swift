#if !(os(macOS) || os(watchOS))
import UIKit

public extension UIBarButtonItem {
  func getView() -> UIView {
    value(forKey: "view") as! UIView
  }
}
#endif
