import HM
import XCTest

final class SetAlgebraTypeTestCase: XCTestCase {
	func test_insert() {
		var options: Options = [.A1, .B2]
		
		options += .C3
		
		XCTAssertEqual(
			options,
			[	.A1,
			 	.B2,
				.C3
			]
		)
	}
	
	func test_remove() {
		var options: Options = [.A1, .B2]
		
		options -= .C3
		options -= .A1
		
		XCTAssertEqual(options, [.B2])
	}
	
	func test_intersect() {
		var options: Options = [
			.A1,
			.B2,
			.C3
		]
		options = options ∩ [
			.A1,
			.C3,
			.D4,
			.F6
		]
		
		XCTAssertEqual(
			options,
			[.C3, .A1]
		)
	}
	
	func test_intersectEquals() {
		var options: Options = [
			.A1,
			.B2,
			.C3
		]
		options ∩= [
			.A1,
			.C3,
			.D4,
			.F6
		]
		
		XCTAssertEqual(
			options,
			[.C3, .A1]
		)
	}
	
	func test_union() {
		var options: Options = [
			.A1,
			.B2,
			.C3,
			.E5
		]
		options = options ∪ [
			.A1,
			.C3,
			.D4,
			.E5,
			.F6
		]
		
		XCTAssertEqual(
			options,
			[	.A1,
				.B2,
				.C3,
				.D4,
				.E5,
				.F6
			]
		)
	}
	
	func test_unionEquals() {
		var options: Options = [
			.A1,
			.B2,
			.C3,
			.E5
		]
		options ∪= [
			.A1,
			.C3,
			.D4,
			.E5,
			.F6
		]
		
		XCTAssertEqual(
			options,
			[ .A1,
			  .B2,
			  .C3,
			  .D4,
			  .E5,
			  .F6
			]
		)
	}
}

private struct Options: OptionSet {
	init(rawValue: UInt) {
		self.rawValue = rawValue
	}
	
	let rawValue: UInt
	
	static let (
		A1,
		B2,
		C3,
		D4,
		E5,
		F6
	) = Options.selfs()
}
