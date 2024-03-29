#if !(os(macOS) || os(watchOS))
import UIKit

public extension UIResponder {
  func disableInputAssistantItem() {
    [ \UITextInputAssistantItem.leadingBarButtonGroups,
      \.trailingBarButtonGroups
    ].forEach { inputAssistantItem[keyPath: $0].removeAll() }
  }
}
#endif
