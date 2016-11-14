import HM
import XCTest

final class WeakClosureTestCase: XCTestCase {
	func testWeakClosure() {
		var reference: Reference? = Reference()
		
		let getAssign1234 = weakClosure(reference){
			reference in {reference.property = 1234}
		}
		
		getAssign1234()!()
		XCTAssertEqual(
			reference!.property,
			1234
		)
		
		reference = nil
		XCTAssertNil(
			getAssign1234()
		)
	}
	
	func testWeakClosureWithParameter() {
		var reference: Reference? = Reference()
		
		let getSetProperty = weakClosure(reference){
			reference, int in reference.property = int
		}
		
		getSetProperty()!(1234)
		XCTAssertEqual(
			reference!.property,
			1234
		)
		
		reference = nil
		XCTAssertNil(
			getSetProperty()
		)
	}
	
}

private final class Reference {
	var property = 1
}
