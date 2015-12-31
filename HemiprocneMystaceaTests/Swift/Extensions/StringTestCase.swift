import HemiprocneMystacea
import XCTest

final class StringTestCase: XCTestCase {
   func testEpsilon() {
      XCTAssertEqual(
       ∑["a", "bc", "d"],
      "abcd"
      )
   }

   func testSplit() {
      let string = "boo, gee,rye"
      XCTAssertEqual(
         string.split(by: ","),
         ["boo", " gee", "rye"]
      )
   }

//MARK:- upTo
   func testUpTo() {
      XCTAssertEqual(
         "glorb14prawn".upTo("1"),
         "glorb"
      )
   }

   func testUpToWithCharacterIncluded() {
      XCTAssertEqual(
         "glorb14prawn".upTo("1", characterIsIncluded: true),
         "glorb1"
      )
   }
   
   func testUpToWithNonPresentCharacter() {
      XCTAssertEqual(
         "boogalawncare".upTo("z"),
         nil
      )
   }
}