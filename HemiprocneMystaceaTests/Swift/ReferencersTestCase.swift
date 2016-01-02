import HemiprocneMystacea
import XCTest

final class ReferencersTestCase: XCTestCase {
//MARK:- UnownedReferencer
   func testUnownedReferencer() {
      var `class`: Class! = Class()
      let referencer = UnownedReferencer(`class`)
      weak var reference = referencer.reference
      XCTAssertNotNil(reference)
      `class` = nil
      XCTAssertNil(reference)
   }
   
   func testUnownedReferencerSetRemoval() {
      let `class` = Class()
      var referencers: Set = [UnownedReferencer(`class`)]
      referencers -= `class`
      XCTAssertEqual(referencers, [])
   }
   
//MARK:- WeakReferencer
   func testWeakReferencer() {
      var `class`: Class? = Class()
      let referencer = WeakReferencer(`class`!)
      `class` = nil
      XCTAssertNil(referencer.reference)
   }
   
   func testWeakReferencerSetRemoval() {
      let `class` = Class()
      var referencers: Set = [WeakReferencer(`class`)]
      referencers -= `class`
      XCTAssertEqual(referencers, [])
   }
}

private class Class: EquatableClass {}