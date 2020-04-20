import HM
import XCTest

private final class CaseIterableTestCase: XCTestCase {
  func test_subscript_case() {
    enum 🦇: CaseIterable { case 🧛🏻, 🦹🏿, 🏏 }
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
}
