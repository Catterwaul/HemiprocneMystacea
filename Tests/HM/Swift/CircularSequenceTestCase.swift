import HM
import XCTest

final class CircularSequenceTestCase: XCTestCase {
  func test() {
    enum 🦇: CaseIterable { case 🧛🏻, 🦹🏿, 🏏 }
    XCTAssertEqual(
      Array( CircularSequence(🦇.allCases).prefix(5) ),
      [.🧛🏻, .🦹🏿, .🏏, .🧛🏻, .🦹🏿]
    )

    var iterator = CircularSequence(🦇.allCases).makeIterator()
    for _ in 1...(🦇.allCases.count * 2 + 1) {
      _ = iterator.next()
    }
    XCTAssertEqual(iterator.next(), .🦹🏿)
  }
}
