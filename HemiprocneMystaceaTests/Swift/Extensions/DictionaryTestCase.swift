import HemiprocneMystacea
import XCTest

final class DictionaryTestCase: XCTestCase {
//MARK:- Subscripts
   func testOptionalKeySubscript() {
      let dictionary = ["key": "value"]
      let key: String? = "key"
      let none: String? = nil
      XCTAssertEqual(dictionary[key], "value")
      XCTAssertEqual(dictionary[none], nil)
   }
   
   func testValueAddedIfNilSubscript() {
      var dictionary = ["key": "value"]
      let valyoo = "valyoo"
      XCTAssertEqual(
         dictionary["kee", valueAddedIfNil: valyoo],
         valyoo
      )
      XCTAssertEqual(
         dictionary,
         ["key": "value", "kee": "valyoo"]
      )
   }

//MARK:- Operators
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