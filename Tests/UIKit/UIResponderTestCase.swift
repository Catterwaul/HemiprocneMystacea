#if !(os(macOS) || os(watchOS))
import XCTest

final class UIResponderTestCase: XCTestCase {
  func test_disableInputAssistantItem() {
    let textField = UITextField()
    textField.disableInputAssistantItem()
  }
}
#endif
