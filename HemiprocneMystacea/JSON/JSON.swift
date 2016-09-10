import Foundation

/// Adds strong typing to treating JSON as a dictionary.
public struct JSON {
	fileprivate typealias Object = [String: AnyObject]
	
	public init(object: Any) {
		self.object = object as! Object
	}
	
	fileprivate let object: Object
}

//MARK: public
public extension JSON {
    init(data: Data) throws {
        self.init(
            object: try JSONSerialization.jsonObject(
					with: data,
					options: .allowFragments
            ) as! Object
        )
    }

//MARK:
	/// Should just be a generic, throwing subscript, but those don't exist yet.
	func get_value<Value>(key: String) throws -> Value {
		guard let object: AnyObject = object[key]
		else {throw Error.noValue(key: key)}
		
		guard let value = object as? Value
		else {throw Error.typeCastFailure(key: key)}
		
		return value
	}
	
	/// Should just be a generic, throwing subscript, but those don't exist yet.
	func get_value<
		Key: RawRepresentable,
		Value
	>(key: Key) throws -> Value
	where Key.RawValue == String {
		return try self.get_value(key: key.rawValue)
	}
}

//MARK:- Error
public extension JSON {
	enum Error: Swift.Error {
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
