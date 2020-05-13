import HM
import XCTest

private final class CaseIterableTestCase: XCTestCase {
  func test_getRange() {
    enum Alphabet: CaseIterable {
      case a, b, c, d, e, f, g
    }

    XCTAssertEqual(
      Alphabet.c...(.f),
      [.c, .d, .e, .f]
    )
  }

  func test_getCaseIndex() {
    enum 💄: CaseIterable {
      static var allCases: [Self] { [] }
      case 💋
    }
    
    XCTAssertThrowsError( try 💄.💋.getCaseIndex() ) { error in
      guard case AnyCaseIterable.AllCasesError<💄>.noIndex(.💋) = error
      else { XCTFail(); return }
    }
  }

  func test_Comparable() {
    enum 🦇: CaseIterable, comparable {
      case 🧛🏻, 🦹🏿, 🏏
    }

    XCTAssertLessThan(🦇.🦹🏿, .🏏)
  }
}
