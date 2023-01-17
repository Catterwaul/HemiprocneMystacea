#if !(os(macOS) || os(watchOS))
import UIKit

public extension UIView {
  /// - Returns: All subviews of type `View`.
  func subviews<View: UIView>() -> [View] {
    subviews.compactMap { $0 as? View }
  }

  /// Add a subview with the same dynamic frame.
  func addConstrainedSubview<Subview: UIView>(_ subview: Subview) {
    subview.translatesAutoresizingMaskIntoConstraints = false
    addSubview(subview)
    NSLayoutConstraint.activate([
      subview.centerXAnchor.constraint(equalTo: centerXAnchor),
      subview.centerYAnchor.constraint(equalTo: centerYAnchor),
      subview.widthAnchor.constraint(equalTo: widthAnchor),
      subview.heightAnchor.constraint(equalTo: heightAnchor)
    ])
  }
}
#endif
