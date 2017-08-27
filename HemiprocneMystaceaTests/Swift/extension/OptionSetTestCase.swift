import HM
import XCTest

final class OptionSetTypeTestCase: XCTestCase {
	func test_2Flags() {
		let options: Options = [.option1, .option2]
		XCTAssertEqual(options.rawValue, 0b11)
	}
	
	func test_3Flags() {
		let options: Options = [
			.option3,
			.option4,
			.option5
		]
		XCTAssertEqual(options.rawValue, 0b1_1100)
	}
	
	func test_4Flags() {
		let options: Options = [
			.option6,
			.option7,
			.option8,
			.option9
		]
		XCTAssertEqual(options.rawValue, 0b1_1110_0000)
	}
	
	func test_5Flags() {
		let options: Options = [
			.option10,
			.option11,
			.option12,
			.option13,
			.option14
		]
		XCTAssertEqual(options.rawValue, 0b11_1110_0000_0000)
	}
	
	func test_6Flags() {
		let options: Options = [
			.option15,
			.option16,
			.option17,
			.option18,
			.option19,
			.option20
		]
		XCTAssertEqual(options.rawValue, 0b1111_1100_0000_0000_0000)
	}
}

private struct Options: OptionSet {
	init(rawValue: UInt) {
		self.rawValue = rawValue
	}
	
	let rawValue: UInt
	
	static let (option1, option2) = Options.makeOptions()
	static let (
		option3,
		option4,
		option5
	) = Options.makeOptions(startingFlagIndex: 3)
	static let (
		option6,
		option7,
		option8,
		option9
	) = Options.makeOptions(startingFlagIndex: 6)
	static let (
		option10,
		option11,
		option12,
		option13,
		option14
	) = Options.makeOptions(startingFlagIndex: 10)
	static let (
		option15,
		option16,
		option17,
		option18,
		option19,
		option20
	) = Options.makeOptions(startingFlagIndex: 15)
}