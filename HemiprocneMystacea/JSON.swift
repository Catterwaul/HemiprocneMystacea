import Foundation

/// Adds strong typing to treating JSON as a dictionary.
public struct JSON {
    public init(object: AnyObject) {
        self.object = object
    }

    private let object: AnyObject
}

//MARK: public
public extension JSON {
    init(data: Data) throws {
        self.init(
            object: try JSONSerialization.jsonObject(
					with: data,
					options: .allowFragments
            )
        )
    }

	/// Should just be a generic, throwing subscript, but those don't exist yet.
	func get_value
	<Value>
	(key: String) throws -> Value {
		guard let object: AnyObject = object[key]
		else {
			throw Error.noValue(key: key)
		}
		
		guard let value = object as? Value
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
		let objects: [AnyObject] = try jSON.get_value(key: key)
		self = objects.map{
			Element(
				jSON: JSON(object: $0)
			)
		}
	}
}
