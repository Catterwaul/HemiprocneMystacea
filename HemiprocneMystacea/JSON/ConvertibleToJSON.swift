import Foundation

public extension JSON {
	typealias Dictionary = [String: AnyObject]
}

public protocol ConvertibleToJSON {
    ///- Important: This is a nested type with this signature:
    ///  `enum JSONKey: String`
	associatedtype JSONKey: RawRepresentable
	
	var jSONDictionary: JSON.Dictionary {get}
}

public extension ConvertibleToJSON where JSONKey.RawValue == String {
    var jSONDictionary: JSON.Dictionary {
        return Mirror(reflecting: self).children.flatMap{
            label, value in
            
            guard let label = label
            where JSONKey(rawValue: label) != nil
            else {return nil}
            
            let value: AnyObject = {
                switch value {
                case let value as ConvertibleToJSON: return value.jSONDictionary
                default: return value as! AnyObject
                }
            }()
            
            return (
                key: label,
                value: value
            )
        }…Dictionary.init
    }
}

public extension JSON {
	init
	<ConvertibleToJSON: HM.ConvertibleToJSON>
	(_ convertibleToJSON: ConvertibleToJSON) throws {
		try self.init(
			data: try Data(convertibleToJSON: convertibleToJSON)
		)
	}
}

public extension Data {
	init
	<ConvertibleToJSON: HM.ConvertibleToJSON>
	(convertibleToJSON: ConvertibleToJSON) throws {
		try self.init(jSONObject: convertibleToJSON.jSONDictionary)
	}
	
	init
	<ConvertibleToJSON: HM.ConvertibleToJSON>(
		key: String, value: ConvertibleToJSON
	) throws {
		try self.init(
			jSONObject: [key: value.jSONDictionary]
		)
	}
	
	init(jSONObject: AnyObject) throws {
		try self = JSONSerialization.data(
			withJSONObject: jSONObject,
			options: .prettyPrinted
		)
	}
}
