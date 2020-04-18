import UIKit

/// A `UITapGestureRecognizer` that wraps a closure.
public final class TapGestureRecognizer: UITapGestureRecognizer {
  init(_ perform: @escaping () -> Void) {
    self.perform = .init(perform)
    super.init(target: self.perform, action: self.perform.selector)
  }

  let perform: Selector.Perform
}
