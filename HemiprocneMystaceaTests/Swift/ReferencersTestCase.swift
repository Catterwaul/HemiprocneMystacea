import HemiprocneMystacea
import XCTest

final class ReferencersTestCase: XCTestCase {
//MARK:- UnownedReferencer
   func testUnownedReferencer() {
      var `class`: Class! = Class()
      let referencers = [
         UnownedReferencer(`class`),
         UnownedReferencer(`class`)
      ]
      weak var reference = referencers.last!.reference
      XCTAssertNotNil(reference)
      `class` = nil
      XCTAssertNil(reference)
   }
   
   func testUnownedReferencerSetRemoval() {
      let `class` = Class()
      var referencers: Set = [UnownedReferencer(`class`)]
      referencers -= `class`
      referencers -= Class()
      XCTAssertEqual(referencers, [])
   }
   
//MARK:- WeakReferencer
   func testWeakReferencer() {
      var `class`: Class! = Class()
      let referencers = [
         WeakReferencer(`class`),
         WeakReferencer(`class`)
      ]
      `class` = nil
      XCTAssertNil(referencers.last!.reference)
   }
   
   func testWeakReferencerSetRemoval() {
      let `class` = Class()
      var referencers: Set = [WeakReferencer(`class`)]
      referencers -= `class`
      referencers -= Class()
      XCTAssertEqual(referencers, [])
   }
}

private class Class: EquatableClass {}