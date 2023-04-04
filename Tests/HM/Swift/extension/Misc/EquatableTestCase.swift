import HM
import XCTest

final class EquatableTestCase: XCTestCase {
  func test_equate() {
    let int: some Any = Int.random(in: .min...(.max))
    let bool: any Any = Bool.random()

    XCTAssertTrue(Int.equate(int, int))
    XCTAssertTrue(.equate(bool, bool))
    XCTAssertFalse(.equate(int, int))

    XCTAssertTrue(AnyHashable.equate(bool, bool))
    XCTAssertFalse(AnyHashable.equate(bool, int))
    
    struct Equatable: Swift.Equatable { }
    XCTAssertTrue(Equatable.equate(Equatable(), Equatable()))
  }

  func test_getEquals() throws {
    let cupcake = "🧁"
    let notCake = 0xca_e

    let cupcakeEquals: (Any) -> Bool = try XCTSkip.uponFailure(
      of: cupcake.getEquals()
    )
    XCTAssert(cupcakeEquals(cupcake))
    XCTAssertFalse(cupcakeEquals(notCake))

    let notCakeEquals = try notCake.getEquals(Any.self)
    XCTAssert(notCakeEquals(notCake))
    XCTAssertFalse(notCakeEquals(cupcake))

    XCTAssertThrowsError(try cupcake.getEquals(Int.self))

    let anyEquatable = try AnyEquatable<Any>(cupcake)
    XCTAssertEqual(anyEquatable, try .init(cupcake))
    XCTAssert(anyEquatable == cupcake)
    XCTAssertFalse(notCake == anyEquatable)
  }
}
