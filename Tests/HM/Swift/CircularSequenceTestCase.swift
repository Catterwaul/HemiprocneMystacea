import HM
import XCTest

final class CircularSequenceTestCase: XCTestCase {
  func test() {
    enum 🦇: CaseIterable { case 🧛🏻, 🦹🏿, 🏏 }

    let circularSequence = CircularSequence(🦇.allCases)
    let anySequence = AnySequence(cycling: 🦇.allCases)

    func makePrefixArray<Sequence: Swift.Sequence>(_ sequence: Sequence) -> [Sequence.Element] {
      .init( sequence.prefix(5) )
    }
    let fiveBats = [🦇.🧛🏻, .🦹🏿, .🏏, .🧛🏻, .🦹🏿]
    XCTAssertEqual(makePrefixArray(circularSequence), fiveBats)
    XCTAssertEqual(makePrefixArray(anySequence), fiveBats)

    var circularSequenceIterator = circularSequence.makeIterator()
    let anySequenceIterator = anySequence.makeIterator()
    for _ in 1...(🦇.allCases.count * 2 + 1) {
      _ = ( circularSequenceIterator.next(), anySequenceIterator.next() )
    }
    XCTAssertEqual(circularSequenceIterator.next(), .🦹🏿)
    XCTAssertEqual(anySequenceIterator.next(), .🦹🏿)
  }
}
