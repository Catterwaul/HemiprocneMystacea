import HM
import XCTest

final class PatternMatchingTestCase: XCTestCase {
  func test_set() throws {
    enum 📧<Brief> {
      case 💼(Brief)

      var brief: Brief {
        get {
          guard case .💼(let brief) = self else {
            fatalError()
          }
          return brief
        }
      }
    }

    var instance = 📧.💼("🩲")
    try set(&instance, \.brief, { _ in "👙" }, 📧.💼)
    XCTAssertEqual(instance.brief, "👙")
  }

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

  func test_enum_Equatable() {
    enum 📧: Equatable {
      case tuple(cat: String, hat: String)
      case anotherTuple(cat: String, hat: String)
      case labeled(cake: String)
      case noAssociatedValue
    }

    let tupleCase = 📧.tuple(cat: "🐯", hat: "🧢")
    XCTAssert(📧.tuple ~= tupleCase)
    XCTAssertFalse(📧.anotherTuple ~= tupleCase)

    XCTAssert(📧.labeled ~= 📧.labeled(cake: "🍰"))

    let makeTupleCase = 📧.tuple
    XCTAssertFalse(makeTupleCase ~= 📧.noAssociatedValue)

    switch tupleCase {
    case 📧.labeled: XCTFail()
    case makeTupleCase: break
    default: XCTFail()
    }
  }

  func test_enum_NotEquatable() {
    enum 📧 {
      case tuple(cat: String, hat: String)
      case anotherTuple(cat: String, hat: String)
      case labeled(cake: String)
      case noAssociatedValue
    }

    let tupleCase = 📧.tuple(cat: "🐯", hat: "🧢")
    XCTAssert(📧.tuple ~= tupleCase)
    XCTAssertFalse(📧.anotherTuple ~= tupleCase)

    XCTAssert(📧.noAssociatedValue ~= .noAssociatedValue)
    XCTAssert(📧.labeled ~= 📧.labeled(cake: "🍰"))

    let makeTupleCase = 📧.tuple
    XCTAssertFalse(makeTupleCase ~= 📧.noAssociatedValue)

    switch tupleCase {
    case 📧.labeled: XCTFail()
    case makeTupleCase: break
    default: XCTFail()
    }
  }
}
