import Foundation

/// Adds strong typing to treating JSON as a dictionary.
public struct JSON {
	fileprivate typealias Object = [String: Any]
	
	public init(object: Any) throws {
      guard let object = object as? Object
      else {
         struct Error: Swift.Error {}
         throw Error()
      }
    
      self.object = object
	}
	
	fileprivate let object: Object
}

//MARK: public
public extension JSON {
	init(data: Data) throws {
		try self.init(
			object: try JSONSerialization.jsonObject(
				with: data,
				options: .allowFragments
			)
		)
	}
}

//MARK: StringKeyDictionary_throws
extension JSON: keyValueThrowingSubscript {
	public func getValue<Value>(key: String) throws -> Value {
		guard let object = object[key]
		else {throw Error.noValue(key: key)}
		
		guard let value = object as? Value
		else {throw Error.typeCastFailure(key: key)}
		
		return value
	}
}


//MARK:- Error
public extension JSON {
	enum Error: Swift.Error {
		case noValue(key: String)
		case typeCastFailure(key: String)
	}
}

//MARK:- InitializableWithJSON
public protocol InitializableWithJSON {
    init(json: JSON)
}

public extension Array where Element: InitializableWithJSON {
	init(
		json: JSON,
		key: String
	) throws {
		let objects: [Any] = try json.getValue(key: key)
		self = try objects.map{
			object in Element(
				json: try JSON(object: object)
			)
		}
	}
}
