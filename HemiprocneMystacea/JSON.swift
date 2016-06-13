/// Adds strong typing to treating JSON as a dictionary.
public struct JSON {
	private let jSON: AnyObject
}

//MARK: public
public extension JSON {
	init(_ jSON: AnyObject) {
		self.jSON = jSON
	}
	
	/// Should just be a generic, throwing subscript, but those don't exist yet.
	func `subscript`
	<Value>
	(key: String) throws -> Value {
		guard let anyObject = jSON[key]!
		else {throw Error.noValue(key: key)}
		
		guard let value = anyObject as? Value
		else {throw Error.typeCastFailure(key: key)}
		
		return value
	}
}

//MARK:- Error
public extension JSON {
	enum Error: ErrorType {
		case
		noValue(key: String),
		typeCastFailure(key: String)
	}
}