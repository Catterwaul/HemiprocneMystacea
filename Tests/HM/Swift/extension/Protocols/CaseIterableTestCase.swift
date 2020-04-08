import HM
import XCTest

private final class CaseIterableTestCase: XCTestCase {
  enum 🦇: CaseSequence {
    case 🧛🏻, 🦹🏿, 🏏
  }

  func test_subscript_case() {
    XCTAssertEqual(🦇[.🦹🏿], 1)
  }

  func test_getRange() {
    enum Alphabet: CaseIterable {
      case a, b, c, d, e, f, g
    }

    XCTAssertEqual(
      Alphabet.c...(.f),
      [.c, .d, .e, .f]
    )
  }

  func test_Sequence() {
    var bat = 🦇.🏏
    _ = bat.next()
    XCTAssertEqual(bat, .🧛🏻)

    XCTAssert(
      [.🦹🏿, .🏏, .🧛🏻, .🦹🏿 ].elementsEqual( bat.prefix(4) )
    )
  }
}
