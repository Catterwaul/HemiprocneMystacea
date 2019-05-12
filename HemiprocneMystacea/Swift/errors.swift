/// A workaround for not being able to conform collections of errors to `Error`
/// with public extensions.
public struct Errors: Error {
  /// Every element is a single error. None are `Errors`.
  /// Modify it using `Errors`' `+=` operator.
	public private(set) var flatArray: [Error]
}

public extension Errors {
  static func += (errors: inout Errors, error: Error) {
    switch error {
    case let multipleErrors as Errors:
      errors.flatArray += multipleErrors.flatArray
    default:
      errors.flatArray.append(error)
    }
  }

//MARK: init
  init<Errors: Sequence>(_ errors: Errors)
  where Errors.Element == Error {
    flatArray = Array(errors)
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
	let errors = validates.reduce( into: Errors() ) { errors, validate in
		do { try validate(parameters) }
    catch { errors += error }
	}
	
	guard errors.flatArray.isEmpty
	else { throw errors }
}
