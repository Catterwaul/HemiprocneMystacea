import HemiprocneMystacea
import XCTest

final class SetTestCase: XCTestCase {
   func testInsert() {
      var set: Set = [1, 2]
      set += 3
      XCTAssertEqual(set, [1, 2, 3])
   }
   
   func testRemove() {
      var set: Set = [1, 2]
      set -= 1
      set -= 3
      XCTAssertEqual(set, [2])
   }
   
   func testIntersect() {
      let set = [1, 2, 3] ∩ [2, 3, 4, 785723948]
      XCTAssertEqual(set, [2, 3])
   }
   
   func testUnion() {
      let set = [0, 1, 2, 3] ∪ [2, 3, 4, 5, 6]
      XCTAssertEqual(set, [0, 1, 2, 3, 4, 5, 6])
   }
}