public struct Errors: Error {
	public let array: [Error]
}

public extension Errors {
//MARK: init
  init<Errors: Sequence>(_ errors: Errors)
	where Errors.Element == Error {
		array = Array(errors)
	}
	
	init(_ errors: Error...) {
		self.init(errors)
	}
}

public func validate<
	Validates: Sequence,
	Parameters
>(
	_ validates: Validates,
	parameters: Parameters
) throws
where Validates.Element == Validate<Parameters> {
	let errors = validates.flatMap { validate -> [Error] in
		do {
			try validate(parameters)
			return []
		}
		catch let errors as Errors {
			return errors.array
		}
		catch { return [error] }
	}
	
	guard errors.isEmpty
	else { throw Errors(errors) }
}
