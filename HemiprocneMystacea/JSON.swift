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
	func get_value
	<Value>
	(key: String) throws -> Value {
		guard let anyObject = jSON[key]!
		else {
			throw Error.noValue(key: key)
		}
		
		guard let value = anyObject as? Value
		else {
			throw Error.typeCastFailure(key: key)
		}
		
		return value
	}
	/// Should just be a generic, throwing subscript, but those don't exist yet.
	func get_value<
		Key: RawRepresentable,
		Value
		where Key.RawValue == String
	>(key: Key) throws -> Value {
		return try self.get_value(key: key.rawValue)
	}
}

//MARK:- Error
public extension JSON {
	enum Error: ErrorProtocol {
		case
		noValue(key: String),
		typeCastFailure(key: String)
	}
}

//MARK:- InitializableWithJSON
public protocol InitializableWithJSON {
    init(jSON: JSON)
}

public extension Array where Element: InitializableWithJSON {
	init(
		jSON: JSON,
		key: String
	) throws {
		let anyObjects: [AnyObject] = try jSON.get_value(key: key)
		
		self = anyObjects.map{
			Element(
				jSON: JSON($0)
			)
		}
	}
}
