import HM
import XCTest

final class ReferencersTestCase: XCTestCase {
//MARK:- UnownedReferencer
   func test_unownedReferencer() {
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
   
   func test_unownedReferencerSetRemoval() {
      let `class` = Class()
      var referencers: Set = [UnownedReferencer(`class`)]
      referencers -= `class`
      referencers -= Class()
      XCTAssertEqual(referencers, [])
   }
   
//MARK:- WeakReferencer
   func test_weakReferencer() {
      var `class`: Class! = Class()
      let referencers = [
         WeakReferencer(`class`),
         WeakReferencer(`class`)
      ]
      `class` = nil
      XCTAssertNil(referencers.last!.reference)
   }
   
   func test_weakReferencerSetRemoval() {
      let `class` = Class()
      var referencers: Set = [WeakReferencer(`class`)]
      referencers -= `class`
      referencers -= Class()
      XCTAssertEqual(referencers, [])
   }
}

private class Class: EquatableClass {}
