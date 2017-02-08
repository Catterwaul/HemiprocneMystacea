import HM
import XCTest

final class errorsTestCase: XCTestCase {
	func test_noErrors() {
		do {
			try validate(
				[{_ in}],
				parameters: "whatever"
			)
		}
		catch {XCTFail()}
	}
	
	func test_errors() {
		do {
			try validate(
				[throwBad, throwsStrongBads],
				parameters: false
			)
		}
		catch let errors as Errors {
			XCTAssertEqual(
				errors.array as! [Error],
				[	.bad,
				 	.strongBad, .strongBad
				]
			)
		}
		catch {XCTFail()}
	}
}

private enum Error: Swift.Error {
	case bad, strongBad
}

private func throwBad(_: Bool) throws {
	throw Error.bad
}

private func throwsStrongBads(_: Bool) throws {
	throw Errors(Error.strongBad, Error.strongBad)
}
