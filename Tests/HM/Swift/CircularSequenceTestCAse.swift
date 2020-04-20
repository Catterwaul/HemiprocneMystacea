import HM
import XCTest

final class CircularSequenceTestCAse: XCTestCase {
  func test() {
    enum 🦇: CaseIterable { case 🧛🏻, 🦹🏿, 🏏 }
    XCTAssertEqual(
      Array( CircularSequence(🦇.allCases).prefix(5) ),
      [.🧛🏻, .🦹🏿, .🏏, .🧛🏻, .🦹🏿]
    )
  }
}
