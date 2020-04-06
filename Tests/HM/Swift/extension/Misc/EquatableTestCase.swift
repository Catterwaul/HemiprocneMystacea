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
}
