import HemiprocneMystacea
import XCTest

final class NilClosuresTestCase: XCTestCase {
  func testNilledUponCall() {
    var closure: (() -> ())! {
      didSet {
        closure = nilledUponCall(closure){closure = $0}
      }
    }
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
  
  func test2Nils() {
    let ƒ: (
      (Int) -> ()?,
      () -> Bool?
    ) = Nils()
    XCTAssertNil(
      ƒ.0(Int.min)
    )
    XCTAssertNil(
      ƒ.1()
    )
  }
  
  func test3Nils() {
    let ƒ: (
      (Int) -> ()?,
      () -> Bool?,
      (String) -> String?
    ) = Nils()
    XCTAssertNil(
      ƒ.0(Int.min)
    )
    XCTAssertNil(
      ƒ.1()
    )
    XCTAssertNil(
      ƒ.2("sgsfdgghnyyje")
    )
  }
  
  func test4Nils() {
    let ƒ: (
      (Int) -> ()?,
      () -> Bool?,
      (String) -> String?,
      () -> ()?
    ) = Nils()
    XCTAssertNil(
      ƒ.0(Int.min)
    )
    XCTAssertNil(
      ƒ.1()
    )
    XCTAssertNil(
      ƒ.2("sgsfdgghnyyje")
    )
    XCTAssertNil(
      ƒ.3()
    )
  }
}
