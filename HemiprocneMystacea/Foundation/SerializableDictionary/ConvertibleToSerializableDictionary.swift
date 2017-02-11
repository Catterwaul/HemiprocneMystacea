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
	
	func makeJSONData(
		options: JSONSerialization.WritingOptions = [],
		key: String? = nil
	) throws -> Data {
		return try JSONSerialization.data(
			withJSONObject: serializableDictionaries[key],
			options: options
		)
	}
	
	func makePropertyListData(
		format: PropertyListSerialization.PropertyListFormat,
		key: String? = nil
	) throws -> Data {
		return try Data(
			propertyList: serializableDictionaries[key],
			format: format
		)
	}
	
	private var serializableDictionaries:
		NamedGetOnlySubscript<String?, [String: Any]>
	{
		return NamedGetOnlySubscript{
			[serializableDictionary]
			key in
				key.map{key in [key: serializableDictionary]}
				?? serializableDictionary
		}
	}
}
