import HM
import XCTest

final class AnySequenceTestCase: XCTestCase {
  func test_init_getNext() {
    XCTAssertEqual(
      AnySequence { "🧞" } .prefix(3).joined(),
      "🧞🧞🧞"
    )
  }

  func test_init_zip() {
    XCTAssert(
      AnySequence.zip(sequences.0, sequences.1)
      ==
      [(1, "🇨🇦"), (2, "🐝"), (3, "🌊"), (4, nil), (5, nil)] as [(Int?, String?)]
    )
  }

  func test_zip() {
    XCTAssert(
      zip(
        sequences.0,
        sequences.1,
        sequences.2
      )
      ==
      [ (1, "🇨🇦", 20),
        (2, "🐝", 40),
        (3, "🌊", 60)
      ]
    )

    XCTAssert(
      zip(
        sequences.0,
        sequences.1,
        sequences.2,
        sequences.3
      )
      ==
      [ (1, "🇨🇦", 20, "😺"),
        (2, "🐝", 40, "😺"),
        (3, "🌊", 60, "😺")
      ]
    )
  }
}

private let sequences = (
  1...5,
  ["🇨🇦", "🐝", "🌊"],
  stride(from: 20, through: 80, by: 20),
  AnyIterator { "😺" }
)
