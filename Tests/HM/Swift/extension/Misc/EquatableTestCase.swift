import HM
import XCTest

final class EquatableTestCase: XCTestCase {
  func test_equate() {
    let int: Any = Int.random( in: .min...(.max) )
    let bool: Any = Bool.random()

    XCTAssertTrue( Int.equate(int, int) )
    XCTAssertTrue( .equate(bool, bool) )
    XCTAssertFalse( .equate(int, int) )

    XCTAssertTrue( AnyHashable.equate(bool, bool) )
    XCTAssertFalse( AnyHashable.equate(bool, int) )
  }

  func test_getEquals() throws {
    let cupcake = "🧁"
    let notCake = 0xca_e

    let cupcakeEquals: (Any) -> Bool = try cupcake.getEquals()
    XCTAssert( cupcakeEquals(cupcake) )
    XCTAssertFalse( cupcakeEquals(notCake) )

    let notCakeEquals = try notCake.getEquals(Any.self)
    XCTAssert( notCakeEquals(notCake) )
    XCTAssertFalse( notCakeEquals(cupcake) )

    XCTAssertThrowsError(
      try cupcake.getEquals() as (Int) -> Bool
    )

    let anyEquatable = try AnyEquatable<Any>(cupcake)
    XCTAssertEqual( anyEquatable, try .init(cupcake) )
    XCTAssert(anyEquatable == cupcake)
    XCTAssertFalse(notCake == anyEquatable)
  }
}
