import HM
import XCTest

final class WeakClosureTestCase: XCTestCase {
	func testWeakClosure() {
		var reference: Reference? = Reference()
		
		let assign1234_get = weakClosure(reference){reference in
			{reference.property = 1234}
		}
		
		assign1234_get()!()
		XCTAssertEqual(
			reference!.property,
			1234
		)
		
		reference = nil
		XCTAssertNil(
			assign1234_get()
		)
	}
	
	func testWeakClosureWithParameter() {
		var reference: Reference? = Reference()
		
		let property_set_get = weakClosure(reference){reference, int in
			reference.property = int
		}
		
		property_set_get()!(1234)
		XCTAssertEqual(
			reference!.property,
			1234
		)
		
		reference = nil
		XCTAssertNil(
			property_set_get()
		)
	}
	
}

private final class Reference {
	var property = 1
}
