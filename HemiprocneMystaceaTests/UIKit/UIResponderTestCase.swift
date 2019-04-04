import HM
import XCTest
import UIKit

final class UIResponderTestCase: XCTestCase {
  func test_disableInputAssistantItem() {
    let textField = UITextField()
    textField.disableInputAssistantItem()
  }
}
