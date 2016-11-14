import HM
import XCTest

final class OptionSetTypeTestCase: XCTestCase {
	func test_2Flags() {
		let options: Options = [.Option1, .Option2]
		XCTAssertEqual(options.rawValue, 0b11)
	}
	
	func test_3Flags() {
		let options: Options = [
			.Option3,
			.Option4,
			.Option5
		]
		XCTAssertEqual(options.rawValue, 0b1_1100)
	}
	
	func test_4Flags() {
		let options: Options = [
			.Option6,
			.Option7,
			.Option8,
			.Option9
		]
		XCTAssertEqual(options.rawValue, 0b1_1110_0000)
	}
	
	func test_5Flags() {
		let options: Options = [
			.Option10,
			.Option11,
			.Option12,
			.Option13,
			.Option14
		]
		XCTAssertEqual(options.rawValue, 0b11_1110_0000_0000)
	}
	
	func test_6Flags() {
		let options: Options = [
			.Option15,
			.Option16,
			.Option17,
			.Option18,
			.Option19,
			.Option20
		]
		XCTAssertEqual(options.rawValue, 0b1111_1100_0000_0000_0000)
	}
}

private struct Options: OptionSet {
	init(rawValue: UInt) {
		self.rawValue = rawValue
	}
	
	let rawValue: UInt
	
	static let
	(Option1, Option2) = Options.selfs()
	static let (
		Option3,
		Option4,
		Option5
	) = Options.selfs(startingFlagIndex: 3)
	static let (
		Option6,
		Option7,
		Option8,
		Option9
	) = Options.selfs(startingFlagIndex: 6)
	static let (
		Option10,
		Option11,
		Option12,
		Option13,
		Option14
	) = Options.selfs(startingFlagIndex: 10)
	static let (
		Option15,
		Option16,
		Option17,
		Option18,
		Option19,
		Option20
	) = Options.selfs(startingFlagIndex: 15)
}
