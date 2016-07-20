public protocol ConvertibleToJSON {
	///- Important: `enum JSONKey: String`
	associatedtype JSONKey: RawRepresentable
	
	var jSONDictionary: [String: AnyObject] {get}
}

public extension ConvertibleToJSON where JSONKey.RawValue == String {
    var jSONDictionary: [String: AnyObject] {
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
	<ConvertibleToJSON: HemiprocneMystacea.ConvertibleToJSON>
	(_ convertibleToJSON: ConvertibleToJSON) throws {
		self.init(
			try JSONSerialization.jsonObject(
				with: try Data(convertibleToJSON: convertibleToJSON)
			)
		)
	}
}

public extension Data {
    init
    <ConvertibleToJSON: HemiprocneMystacea.ConvertibleToJSON>
    (convertibleToJSON: ConvertibleToJSON) throws {
			try self = JSONSerialization.data(
				 withJSONObject: convertibleToJSON.jSONDictionary,
				 options: .prettyPrinted
			)
    }
}
