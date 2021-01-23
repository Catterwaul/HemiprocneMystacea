#if !os(macOS)
import class UIKit.UIView

public extension UIView {
  /// - Returns: all subviews of type `View`
  func getSubviews<View: UIView>() -> [View] {
    subviews.compactMap { $0 as? View }
  }

  /// - Returns: the first subview of type `View`
  func getSubview<View: UIView>() -> View? {
    getSubviews().first
  }
}
#endif
