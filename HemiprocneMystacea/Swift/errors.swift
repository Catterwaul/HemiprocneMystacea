public typealias HashableError = Hashable & Error

public struct Errors<Error: HashableError>: Swift.Error {
	public let set: Set<Error>
	
//MARK: init
	public init<Errors: Sequence>(_ errors: Errors)
	where Errors.Iterator.Element == Error {
		set = Set(errors)
	}
	
	public init(_ errors: Error...) {
		self.init(errors)
	}
}


public typealias Validate<Parameters> = (Parameters) throws -> Void

public func validate<
	Validates: Swift.Sequence,
	Parameters,
	Error: HashableError
>(
	_ validates: Validates,
	parameters: Parameters,
	errorType: Error.Type
) throws
where Validates.Iterator.Element == Validate<Parameters> {
	let errors = validates.flatMap{
		validate -> Set<Error> in
		
		do {
			try validate(parameters)
			return []
		}
		catch let error as Error {
			return [error]
		}
		catch let errors as Errors<Error> {
			return errors.set
		}
		catch {fatalError()}
	}
	
	guard errors.isEmpty
	else {throw Errors(errors)}
}
