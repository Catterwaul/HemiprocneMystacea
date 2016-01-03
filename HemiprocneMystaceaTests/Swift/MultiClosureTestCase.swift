@testable import HemiprocneMystacea
import XCTest

final class MultiClosureTestCase: XCTestCase {
   func testMultiClosure() {
      var x = 0
      let closures = [
         EquatableClosure{x += 1},
         EquatableClosure{x += 2}
      ]
      let multiClosure = MultiClosure(closures)
      multiClosure[]
      XCTAssertEqual(x, 3)
      multiClosure -= closures.first!
      multiClosure[]
      XCTAssertEqual(x, 5)
   }
   
   func testSetRemoval() {
      let
         closure: EquatableClosure<()>! = EquatableClosure{},
         multiClosure = MultiClosure(closure)
      XCTAssertNotEqual(multiClosure.closures, [])
      XCTAssertNotEqual(closure.multiClosures, [])
      multiClosure -= closure
      XCTAssertEqual(multiClosure.closures, [])
      XCTAssertEqual(closure.multiClosures, [])
   }

   func testDeallocation() {
      var
         closure: EquatableClosure<()>! = EquatableClosure{},
         multiClosure: MultiClosure<()>! = MultiClosure(closure)
      
      XCTAssertNotEqual(multiClosure.closures, [])
      closure = nil
      XCTAssertEqual(multiClosure.closures, [])
      
      closure = EquatableClosure{}
      multiClosure += closure
      XCTAssertNotEqual(closure.multiClosures, [])
      multiClosure = nil
      XCTAssertEqual(closure.multiClosures, [])
   }
}