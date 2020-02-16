import HM
import XCTest

final class TupleTestCase: XCTestCase {
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
}

private typealias Illustration = (image: String, TuplePlaceholder)

private func makeIllustrations() -> [Illustration] {
  [ ( image: "🐻", TuplePlaceholder() ),
    ( image: "🍯", TuplePlaceholder() ),
    ( image: "🐝", TuplePlaceholder() )
  ]
}
