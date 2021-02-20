#if !os(macOS)
import class UIKit.UIView

public extension UIView {
  /// - Returns: All subviews of type `View`.
  func subviews<View: UIView>() -> [View] {
    subviews.compactMap { $0 as? View }
  }
}
#endif
