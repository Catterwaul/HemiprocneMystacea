import HemiprocneMystacea
import XCTest

final class NilClosuresTestCase: XCTestCase {
	func testNilledUponCall() {
		var closure: (
			() -> Void
		)? {
			didSet {
				closure = nillifyUponCall(closure){closure = $0}
			}
		}
		
		XCTAssertNil(closure)
		
		closure = {}
		XCTAssertNotNil(closure)
		
		closure!()
		XCTAssertNil(closure)
	}
	
	//MARK:- Nils
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
