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
	(_ key: String) throws -> Value {
		guard let anyObject = jSON[key]!
		else {throw Error.noValue(key: key)}
		
		guard let value = anyObject as? Value
		else {throw Error.typeCastFailure(key: key)}
		
		return value
	}
	/// Should just be a generic, throwing subscript, but those don't exist yet.
	func `subscript`<
		Key: RawRepresentable,
		Value
		where Key.RawValue == String
	>(_ key: Key) throws -> Value {
		return try self.subscript(key.rawValue)
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
		jSON: AnyObject,
		key: String
	) throws {
		guard let anyObjects = jSON[key] as? [AnyObject]
		else {throw JSON.Error.noValue(key: key)}
		
		self = anyObjects.map{
			Element(
				jSON: JSON($0)
			)
		}
	}
}

//MARK:- ConvertibleToJSON
public protocol ConvertibleToJSON: ConvertibleToJSON_where_JSONKey_RawValue_is_String {
	associatedtype JSONKey: RawRepresentable
}
public protocol ConvertibleToJSON_where_JSONKey_RawValue_is_String {
	var jSONDictionary: [String: AnyObject] {get}
}

public extension ConvertibleToJSON where JSONKey.RawValue == String {
	func jSONData_get() throws -> Data {
		return try JSONSerialization.data(
			withJSONObject: jSONDictionary,
			options: .prettyPrinted
		)
	}

	var jSONDictionary: [String: AnyObject] {
		return Dictionary(
			Mirror(reflecting: self).children.flatMap{label, value in
				guard let label = label
				where JSONKey(rawValue: label) != nil
				else {return nil}
				
				return (
					key: label,
					value: {
						switch value {
						case let value as ConvertibleToJSON_where_JSONKey_RawValue_is_String:
							return value.jSONDictionary
						default: return value as! AnyObject
						}
					}()
				)
			}
		)
	}
}
