import HM
import XCTest

final class tupleTestCase: XCTestCase {
  func test_TuplePlaceholder() {
    XCTAssertEqual(makeIllustrations()[1].image, "🍯")
  }

  func test_Sequence() {
    let array = [0, 1, 2, 3]
    XCTAssertTrue( array.tuple2! == (0, 1) )
    XCTAssertTrue( array.tuple3! == (0, 1, 2) )
    XCTAssertTrue( array.tuple4! == (0, 1, 2, 3) )

    XCTAssertNil([].tuple2)
    XCTAssertNil([].tuple3)
    XCTAssertNil([].tuple4)
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
