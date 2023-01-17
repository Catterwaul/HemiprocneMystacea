#if !(os(macOS) || os(watchOS))
import UIKit

public extension UIAlertController {
  convenience init(
    title: String?,
    message: String?,
    style: UIAlertController.Style = .alert,
    actions: [UIAlertAction] = [UIAlertAction.`default`]
  ) {
    self.init(
      title: title,
      message: message,
      preferredStyle: style
    )
    
    add(actions)
  }
  
  final func add(_ actions: [UIAlertAction]) {
    actions.forEach(addAction)
  }
}
#endif
