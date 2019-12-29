import HM
import XCTest

final class PatternMatchingTestCase: XCTestCase {
  func test_closure() {
    switch 4 {
    case
      [1, 2, 3].contains,
      { $0 + 1 == 2 },
      { $0.isMultiple(of: 2) }
    :
      break
    default:
      XCTFail()
    }
  }

  func test_KeyPath() {
    switch "a" as Character {
    case \.isNumber:
      XCTFail()
    default:
      break
    }
  }
}
