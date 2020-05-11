import HM
import XCTest

final class PatternMatchingTestCase: XCTestCase {
  func test_Character() {
    let g: Character = "g"
    switch g {
    case \.isNumber, \.isHexDigit:
      XCTFail()
    case \.isLetter:
      break
    default:
      XCTFail()
    }
  }

  func test_Double() {
    switch 1.0 {
    case
      \.isZero,
      [2, 100, -0.3].contains,
      { $0 != 1 }
    :
      XCTFail()
    case \.isInteger:
      break
    default:
      XCTFail()
    }
  }

  func test_enum() {
    enum 📧: Equatable {
      case tuple(cat: String, hat: String)
      case labeled(cake: String)
      case noAssociatedValue
    }

    let tupleCase = 📧.tuple(cat: "🐯", hat: "🧢")
    XCTAssertTrue(📧.tuple ~= tupleCase)

    XCTAssertTrue( 📧.labeled ~= 📧.labeled(cake: "🍰") )

    let makeTupleCase = 📧.tuple
    XCTAssertFalse(makeTupleCase ~= 📧.noAssociatedValue)

    switch tupleCase {
    case 📧.labeled: XCTFail()
    case makeTupleCase: break
    default: XCTFail()
    }
  }
}
