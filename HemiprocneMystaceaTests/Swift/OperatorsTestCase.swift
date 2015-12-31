import HemiprocneMystacea
import XCTest

final class OperatorsTestCase: XCTestCase {
   func testBullet() {
      func string(int: Int) -> String {return String(int)}
      XCTAssertEqual(22•string, "22")
   }
   
   func testEllipsis() {
      class Class {
         var bool: Bool!
      }
      let `class` = Class()…{
         $0.bool = true
      }
      XCTAssertEqual(`class`.bool, true)
   }
}