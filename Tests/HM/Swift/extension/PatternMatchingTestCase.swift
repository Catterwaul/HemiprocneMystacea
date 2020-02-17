import HM
import XCTest

final class PatternMatchingTestCase: XCTestCase {
  func test_closure() {
    switch 0.1 {
    case
      \.isZero,
      [1, 2, 3].contains,
      { $0 > 1 }
    :
      XCTFail()
    default:
      break
    }
  }

  func test_KeyPath() {
    switch "g" as Character {
    case \.isNumber, \.isHexDigit:
      XCTFail()
    default:
      break
    }
  }
}
