import HM
import XCTest

final class MakeGetTestCase: XCTestCase {
	func test_noParameters() {
		var reference: Reference? = Reference()
		
		let getAssign1234 = makeGet(weakReference: reference){
			$0.property = 1234
		}
		
		getAssign1234()?()
		XCTAssertEqual(reference?.property, 1234)
		
		reference = nil
		XCTAssertNil( getAssign1234() )
	}
	
	func test_1Parameter() {
		var reference: Reference? = Reference()
		
		let getSetProperty = makeGet(weakReference: reference){
			reference, int in reference.property = int
		}
		
		getSetProperty()?(1234)
		XCTAssertEqual(reference?.property, 1234)
		
		reference = nil
		XCTAssertNil( getSetProperty() )
	}
}

private final class Reference {
	var property = 1
}
