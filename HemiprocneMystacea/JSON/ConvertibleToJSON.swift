public protocol ConvertibleToJSON {
    ///- Important: This is a nested type with this signature:
    ///  `enum JSONKey: String`
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

#if os(tvOS)
public typealias Framework_ConvertibleToJSON = HemiprocneMystaceaTV.ConvertibleToJSON
#else
public typealias Framework_ConvertibleToJSON = HemiprocneMystacea.ConvertibleToJSON
#endif

public extension JSON {
	init
	<ConvertibleToJSON: Framework_ConvertibleToJSON>
	(_ convertibleToJSON: ConvertibleToJSON) throws {
		try self.init(
			data: try Data(convertibleToJSON: convertibleToJSON)
		)
	}
}

public extension Data {
    init
    <ConvertibleToJSON: Framework_ConvertibleToJSON>
    (convertibleToJSON: ConvertibleToJSON) throws {
			try self = JSONSerialization.data(
				 withJSONObject: convertibleToJSON.jSONDictionary,
				 options: .prettyPrinted
			)
    }
}
