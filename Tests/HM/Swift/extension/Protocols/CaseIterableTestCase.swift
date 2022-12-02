import HM
import XCTest

private final class CaseIterableTestCase: XCTestCase {
  enum Alphabet: CaseIterable & IteratorProtocol {
    case a, b, c, d, e, f, g,
         z
  }

  func test_getRange() {
    XCTAssertEqual(
      Alphabet.c...(.f),
      [.c, .d, .e, .f]
    )
  }

  func test_caseIndex() {
    enum 🦇: CaseIterable {
      case 🏏, 🧛
    }

    XCTAssertEqual(try 🦇.🧛.caseIndex, 1)

    enum 💄: CaseIterable {
      static var allCases: [Self] { [] }
      case 💋
    }
    
    XCTAssertThrowsError(try 💄.💋.caseIndex) { error in
      guard case AllCasesError<💄>.noIndex(.💋) = error
      else { return XCTFail() }
    }
  }

  func test_nextCase() {
    XCTAssertNil(Alphabet.z.next())
    XCTAssertEqual(Alphabet.z.next() as Alphabet, .a)
  }

  func test_previousCase() {
    XCTAssertNil(Alphabet.allCases[before: .a])
    XCTAssertEqual(Alphabet.allCases.cycled()[before: .a], .z)
  }
}
