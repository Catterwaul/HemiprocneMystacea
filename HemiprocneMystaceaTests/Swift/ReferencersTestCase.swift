import HemiprocneMystacea
import XCTest

final class ReferencersTestCase: XCTestCase {
   func testUnownedReferencer() {
      var `class`: Class! = Class()
      let referencer = UnownedReferencer(`class`)
      weak var reference = referencer.reference
      XCTAssertNotNil(reference)
      `class` = nil
      XCTAssertNil(reference)
   }
   
   func testWeakReferencer() {
      var `class`: Class? = Class()
      let referencer = WeakReferencer(`class`!)
      `class` = nil
      XCTAssertNil(referencer.reference)
   }
}

private class Class {}