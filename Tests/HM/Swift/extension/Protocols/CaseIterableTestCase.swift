import HM
import XCTest

private final class CaseIterableTestCase: XCTestCase {
  enum Alphabet: CaseIterable {
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
    enum 💄: CaseIterable {
      static var allCases: [Self] { [] }
      case 💋
    }
    
    XCTAssertThrowsError( try 💄.💋.caseIndex() ) { error in
      guard case AnyCaseIterable.AllCasesError<💄>.noIndex(.💋) = error
      else { XCTFail(); return }
    }
  }

  func test_nextCase() {
    XCTAssertNil(Alphabet.z.nextCase())
    XCTAssertEqual(Alphabet.z.nextCase(cyclic: true), .a)
  }
}
