import Foundation

public extension JSON {
	typealias Dictionary = [String: AnyObject]
}

public protocol ConvertibleToJSON {
    ///- Important: This is a nested type with this signature:
    ///  `enum JSONKey: String`
	associatedtype JSONKey: RawRepresentable
	
	// Should only be defined in the protocol extension,
	// but we can't yet express that `JSONKey.RawValue == String` is always true.
	var jsonDictionary: JSON.Dictionary {get}
}

public extension ConvertibleToJSON where JSONKey.RawValue == String {
	var jsonDictionary: JSON.Dictionary {
		return Dictionary(
			Mirror(reflecting: self).children.flatMap{
				label, value in
				
				guard
					let label = label,
					JSONKey.contains(label)
				else {return nil}
				
				let value: AnyObject = {
					switch value {
						case let value as ConvertibleToJSON:
							return value.jsonDictionary as AnyObject
						default: return value as AnyObject
					}
				}()
				
				return (
					key: label,
					value: value
				)
			}
		)
	}
}

public extension JSON {
	init<ConvertibleToJSON: HM.ConvertibleToJSON>(_ convertibleToJSON: ConvertibleToJSON) throws {
		try self.init(
			data: try Data(convertibleToJSON: convertibleToJSON)
		)
	}
}

public extension Data {
	/// - returns: `convertibleToJSON`'s `jsonDictionary` serialized JSON with the "prettyPrinted" option
	init<ConvertibleToJSON: HM.ConvertibleToJSON>(convertibleToJSON: ConvertibleToJSON) throws {
		try self.init(jsonObject: convertibleToJSON.jsonDictionary as AnyObject)
	}
	
	/// - returns: `value` serialized as JSON with the "prettyPrinted" option
	init<ConvertibleToJSON: HM.ConvertibleToJSON>(
		key: String,
		value: ConvertibleToJSON
	) throws {
		try self.init(
			jsonObject: [key: value.jsonDictionary] as AnyObject
		)
	}
	
	
	/// - parameter jsonObject: a JSON dictionary
	///
	/// - returns: serialized JSON with the "prettyPrinted" option
	init(jsonObject: AnyObject) throws {
		try self = JSONSerialization.data(
			withJSONObject: jsonObject,
			options: .prettyPrinted
		)
	}
}
