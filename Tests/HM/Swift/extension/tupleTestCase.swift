import HM
import XCTest

final class TupleTestCase: XCTestCase {
  func test_placeholder() {
    func makeIllustrations() -> [(image: String, Never?)] {
      [ (image: "🐻", nil),
        Tuple("🍯").elements,
        ("🐝", nil)
      ]
    }

    XCTAssertEqual(makeIllustrations()[1].image, "🍯")
  }

  func test_callAsFunction() {
    XCTAssertEqual( 🇪🇨(), 🇪🇨() )
  }

  /// Note: outside of test_callAsFunction because `==` can't be overridden there.
  /// (It compiles; it just doesn't work. I logged the bug.)
  private struct 🇪🇨: Equatable {
    let eq = "🎛"
    let u = 1.0 / 1_000_000
    let al = 13

    let probablyNotEqual = UUID()

    static func == (ecuador0: Self, ecuador1: Self) -> Bool {
      let getProperties = Tuple(\Self.eq, \.u, \.al)
      return getProperties(ecuador0) == getProperties(ecuador1)
    }
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
