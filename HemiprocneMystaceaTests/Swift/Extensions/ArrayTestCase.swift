import HemiprocneMystacea
import XCTest

final class ArrayTestCase: XCTestCase {
   func testMinusEquals() {
      var array = [1, 2]
      array -= 1
      array -= 867_5309
      XCTAssertEqual(array, [2])
   }
   
   func testMinusEquals_Predicate() {
      var array = [
				1,
				2,
				3
			]
      array -= {$0 >= 2}
      array -= {$0 > 9_000}
      XCTAssertEqual(
				array,
				[1, 3]
			)
   }
}