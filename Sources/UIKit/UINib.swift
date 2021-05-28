#if !os(macOS)
import UIKit

public extension UINib {
  static func instantiate<Object: AnyObject>(owner: Any? = nil) -> Object? {
    Bundle(for: Object.self)
    .loadNibNamed("\(Object.self)", owner: owner)?
    .firstNonNil { $0 as? Object }
  }
}


/// A workaround for not being able to use a generic `UINib.Superview<Subview: UIView>` due to Objective-C.
///
/// `addSubview` is included in an extension. Suggested usage:
///
///      @IBDesignable final class Superview: UIView, NibSuperview {
///        var subview: Subview!
///
///        override func awakeFromNib() {
///          super.awakeFromNib()
///          subview = addSubview()
///        }
///
///        override func prepareForInterfaceBuilder() {
///          super.prepareForInterfaceBuilder()
///          subview = addSubview()
///        }
///      }
public protocol NibSuperview where Self: UIView {
  associatedtype Subview: UIView

  var subview: Subview! { get }
}

public extension NibSuperview {
  func addSubview() -> Subview {
    let subview: Subview = UINib.instantiate()!
    subview.translatesAutoresizingMaskIntoConstraints = false
    addSubview(subview)
    NSLayoutConstraint.activate([
      subview.centerXAnchor.constraint(equalTo: centerXAnchor),
      subview.centerYAnchor.constraint(equalTo: centerYAnchor),
      subview.widthAnchor.constraint(equalTo: widthAnchor),
      subview.heightAnchor.constraint(equalTo: heightAnchor)
    ])
    return subview
  }
}
#endif
