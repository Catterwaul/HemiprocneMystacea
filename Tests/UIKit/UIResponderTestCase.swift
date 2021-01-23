#if !os(macOS)
import XCTest

final class UIResponderTestCase: XCTestCase {
  func test_disableInputAssistantItem() {
    let textField = UITextField()
    textField.disableInputAssistantItem()
  }
}
#endif
