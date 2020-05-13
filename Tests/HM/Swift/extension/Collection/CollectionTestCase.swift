import HM
import XCTest

final class CollectionTestCase: XCTestCase {
//MARK:- Subscripts

  func test_subscript_maxSubSequenceCount() {
    XCTAssertEqual(
      Array("❤️🌹💄🦋👖🥶♻️"[maxSubSequenceCount: 3]),
      ["❤️🌹💄", "🦋👖🥶", "♻️"]
    )

    XCTAssert(
      Array([Any]()[maxSubSequenceCount: 10]).isEmpty
    )
  }

  func test_subscript_modulo() {
    let ints = [1, 2]
    for (index, int) in [
      (0, 1), (1, 2),
      (2, 1), (3, 2),
      (-1, 2), (-2, 1),
      (-3, 2), (-4, 1)
    ] {
      XCTAssertEqual(ints[modulo: index], int)
    }

    let string = "abc"
    XCTAssertEqual(
      "abc"[modulo: string.index( after: string.firstIndex(of: "c")! )],
      "a"
    )
  }

  func test_subscript_startOffsetBy() {
    XCTAssertEqual("🎤🐈"[startIndexOffsetBy: 1], "🐈")
  }

//MARK:- Methods

  func test_getElement() throws {
    XCTAssertThrowsError( try ["🐾", "🥝"].element(at: 2) )

    let optionals = [1, 2, nil]
    XCTAssertEqual(try optionals.element(at: 0), 1)

    XCTAssertThrowsError( try optionals.element(at: optionals.endIndex) )
    { XCTAssert($0 is AnyCollection<Int?>.IndexingError) }
  }

  func test_prefix() {
    XCTAssertEqual(
      "glorb14prawn".prefix(upTo: "1"),
      "glorb"
    )
    
    XCTAssertEqual(
      "glorb14prawn".prefix(through: "1"),
      "glorb1"
    )

    XCTAssertNil( "boogalawncare".prefix(upTo: "z") )
    XCTAssertNil( "boogalawncare".prefix(through: "z") )
  }

  func test_shifted() {
    XCTAssertEqual(
      Array( stride(from: 0, through: 3, by: 1).shifted(by: 1) ),
      [1, 2, 3, 0]
    )

    XCTAssertEqual(
      Array( [0, 1, 2, 3].shifted(by: -1) ),
      [3, 0, 1, 2]
    )
  }
  
  func test_suffix() {
    XCTAssertEqual(
      "chunky skunky".suffix(from: "s"),
      "kunky"
    )
    XCTAssertNil( "aaabbbccc".suffix(from: "z") )
  }
}
