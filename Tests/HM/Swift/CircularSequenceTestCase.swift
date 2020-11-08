import HM
import XCTest

private final class CircularSequenceTestCase: XCTestCase {
  func test() {
    enum 🦇: CaseIterable { case 🧛🏻, 🦹🏿, 🏏 }

    let circularSequence = CircularSequence(🦇.allCases)
    let fiveBats = [🦇.🧛🏻, .🦹🏿, .🏏, .🧛🏻, .🦹🏿]
    XCTAssertEqual(
      .init(circularSequence.prefix(5)),
      fiveBats
    )

    var circularSequenceIterator = circularSequence.makeIterator()
    for _ in 1...(🦇.allCases.count * 2 + 1) {
      _ = (circularSequenceIterator.next())
    }
    XCTAssertEqual(circularSequenceIterator.next(), .🦹🏿)
  }
}
