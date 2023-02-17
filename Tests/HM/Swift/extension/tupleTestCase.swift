import HM
import XCTest

final class TupleTestCase: XCTestCase {
  func test_reverse() {
    XCTAssert(reverse(1, 2) == (2, 1))
  }

  func test_firstNonNil() {
    var tuple: (String?, String?)
    
    tuple.0 = "🥟"
    XCTAssertEqual(firstNonNil(tuple), "🥟")
    
    tuple = (nil, "🫔")
    XCTAssertEqual(firstNonNil(tuple), "🫔")
    
    tuple.1 = nil
    
    XCTAssertNil(firstNonNil(tuple))
  }
  
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
    XCTAssertEqual(🇪🇨(), 🇪🇨())
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
    XCTAssert(array.tuple2! == (0, 1))
    XCTAssert(array.tuple3! == (0, 1, 2))
    XCTAssert(array.tuple4! == (0, 1, 2, 3))

    XCTAssertNil([Never]().tuple2)
    XCTAssertNil([Never]().tuple3)
    XCTAssertNil([Never]().tuple4)
  }
}
