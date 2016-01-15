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
}