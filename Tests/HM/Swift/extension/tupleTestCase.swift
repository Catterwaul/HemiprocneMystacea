import HM
import XCTest

final class tupleTestCase: XCTestCase {
  func test_TuplePlaceholder() {
    XCTAssertEqual(makeIllustrations()[1].image, "🍯")
  }

  func test_collectionEquality() {
    let twoTuples = makeIllustrations().map { ( $0.image, Bool() ) }
    XCTAssertTrue(twoTuples == twoTuples)
    XCTAssertFalse(twoTuples == [])

    let threeTuples = twoTuples.map { ($0.1, Int(), $0.0) }
    XCTAssertTrue(threeTuples == threeTuples)
    XCTAssertFalse(threeTuples == [(true, 100, "🧠")])
  }
}

private typealias Illustration = (image: String, TuplePlaceholder)

private func makeIllustrations() -> [Illustration] {
  [ ( image: "🐻", TuplePlaceholder() ),
    ( image: "🍯", TuplePlaceholder() ),
    ( image: "🐝", TuplePlaceholder() )
  ]
}
