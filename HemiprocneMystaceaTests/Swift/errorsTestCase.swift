import HM
import XCTest

final class errorsTestCase: XCTestCase {
	func test_noErrors() {
		do {
			try validate(
				[{_ in}],
				parameters: "whatever",
				errorType: Error.self
			)
		}
		catch {XCTFail()}
	}
	
	func test_errors() {
		XCTAssertThrowsError(
			try validate(
				[throwBad, throwsStrongBads],
				parameters: false,
				errorType: Error.self
			)
		){	error in
			
			guard case let errors as Errors<Error> = error
			else {
				XCTFail()
				return
			}
			
			XCTAssertEqual(
				errors.set,
				[Error.bad, Error.strongBad]
			)
		}
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
