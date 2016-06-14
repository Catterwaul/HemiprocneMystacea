import HemiprocneMystacea
import XCTest

final class QuestionMarkEllipsisTestCase: XCTestCase {	
	func testQuestionMarkEllipsis() {
		var int: Int? = 1
		
		XCTAssertEqual(
			int ?… {$0 + 1},
			2
		)
		
		int = nil
		
		XCTAssertNil(
			int ?… {$0 + 1}
		)
	}
	
	func testQuestionMarkEllipsisOptional() {
		let textField = UITextField()
		
		XCTAssertNil(
			nil ?… Double.init
		)
		
		XCTAssertNil(
			textField.text ?… Double.init
		)
		
		textField.text = "22.22"
		XCTAssertEqual(
			textField.text ?… Double.init,
			22.22
		)
	}
}