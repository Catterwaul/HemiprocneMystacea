import HemiprocneMystacea
import XCTest

final class ClosuresTestCase: XCTestCase {
   func testNilledUponCall() {
      var closure: (() -> ())! {didSet {
         closure = nilledUponCall(closure){closure = $0}
      }}
      closure = {}
      XCTAssertNotNil(closure)
      closure()
      XCTAssertNil(closure)
   }
   
   func testNillifyUponCall() {
      var closure: (() -> ())! = {}
      nillifyUponCall(closure){closure = $0}
      XCTAssertNotNil(closure)
      closure()
      XCTAssertNil(closure)
   }
}
