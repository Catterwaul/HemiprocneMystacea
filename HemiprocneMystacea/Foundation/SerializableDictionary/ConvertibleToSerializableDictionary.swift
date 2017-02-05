import Foundation

public protocol ConvertibleToSerializableDictionary {
    ///- Important: This is a nested type with this signature:
    ///  `enum SerializableDictionaryKey: String`
	associatedtype SerializableDictionaryKey: RawRepresentable
	
	// Should only be defined in the protocol extension,
	// but we can't yet express that `JSONKey.RawValue == String` is always true.
   var serializableDictionary: [String: Any] {get}
}

public extension ConvertibleToSerializableDictionary
where SerializableDictionaryKey.RawValue == String {
	var serializableDictionary: [String: Any] {
		return Dictionary(
			Mirror(reflecting: self).children.flatMap{
				label, value in
				
				guard
					let label = label,
					SerializableDictionaryKey.contains(label)
				else {return nil}
				
				let value: Any = {
					switch value {
					case let value as ConvertibleToSerializableDictionary:
						return value.serializableDictionary
            
					default: return value
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

public extension SerializableDictionary {
	init<ConvertibleToSerializableDictionary: HM.ConvertibleToSerializableDictionary>(
      _ convertibleToJSON: ConvertibleToSerializableDictionary
   ) throws {
		try self.init(
			data: try Data(convertibleToJSON: convertibleToJSON)
		)
	}
}
