public typealias HashableError = protocol<ErrorProtocol, Hashable>

public struct Errors
<Error: HashableError>
: ErrorProtocol {
	public init<
		Errors: Sequence where Errors.Iterator.Element == Error
	>(_ errors: Errors) {
		set = Set(errors)
	}
	public init(_ errors: Error...) {
		self.init(errors)
	}
	
	public let set: Set<Error>
}


public typealias Validate<Parameters> = (Parameters) throws -> Void

public func validate<
	Validates: Swift.Sequence,
	Parameters,
	Error: HashableError
	where Validates.Iterator.Element == Validate<Parameters>
>(
	_ validates: Validates,
	parameters: Parameters,
	errorType: Error.Type
) throws {
	let errors = validates.flatMap{
		validate -> Set<Error> in
		
		do {
			try validate(parameters)
			return []
		}
		catch let error as Error {return [error]}
		catch let errors as Errors<Error> {return errors.set}
		catch {fatalError()}
	}
	guard errors.isEmpty
	else {throw Errors(errors)}
}
