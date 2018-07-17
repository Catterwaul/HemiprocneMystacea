import HM
import XCTest

final class errorsTestCase: XCTestCase {
  func test_noErrors() throws {
    try validate(
      [ { _ in } ],
      parameters: "whatever"
    )
  }
	
	func test_errors() throws {
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
