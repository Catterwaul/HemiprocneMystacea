import HemiprocneMystacea
import XCTest

final class DictionaryTestCase: XCTestCase {
   func testPlus() {
      let dictionary = [1: 10, 2: 20]
      XCTAssertEqual(
         dictionary + [3: 30, 4: 40],
         [1: 10, 2: 20, 3: 30, 4: 40]
      )
   }
   
   func testPlusEquals() {
      var dictionary = [1: 10, 2: 20]
      dictionary += [3: 30, 4: 40]
      XCTAssertEqual(
         dictionary,
         [1: 10, 2: 20, 3: 30, 4: 40]
      )
   }
   
   func testMinus() {
      let dictionary = [1: 10, 2: 20, 3: 30]
      XCTAssertEqual(
         dictionary - [1, 3],
         [2: 20]
      )
   }
   
   func testMinusEquals() {
      var dictionary = [1: 10, 2: 20, 3: 30]
      dictionary -= [2: "🏩", 1: "🤘🏽"].keys
      XCTAssertEqual(dictionary, [3: 30])
   }
}