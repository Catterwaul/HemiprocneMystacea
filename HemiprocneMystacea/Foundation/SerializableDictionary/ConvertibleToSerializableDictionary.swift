import UIKit

public protocol ConvertibleToSerializableDictionary {
    ///- Important: This is a nested type with this signature:
    ///  `enum SerializableDictionaryKey: String`
	associatedtype SerializableDictionaryKey: RawRepresentable
	
	// Should only be defined in the protocol extension,
	// but we can't yet express that `JSONKey.RawValue == String` is always true.
	func makeSerializableDictionary(jsonCompatible: Bool) -> [String: Any]
}

public extension ConvertibleToSerializableDictionary
where SerializableDictionaryKey.RawValue == String {
	func makeSerializableDictionary(jsonCompatible: Bool) -> [String: Any] {
		return makeSerializableDictionary(
			jsonCompatible: jsonCompatible,
			key: nil
		)
	}
	
	func makeSerializableDictionary(
		jsonCompatible: Bool,
		key: String? = nil
	) -> [String: Any] {
		let serializableDictionary: [String: Any] = Dictionary(
			Mirror(reflecting: self).children.flatMap{
				label, value in
				
				guard
					let label = label,
					SerializableDictionaryKey.contains(label),
				
               // Don't include keys with nil values.
					!Mirror(reflecting: value).reflectsOptionalNone
				else {return nil}
            
            switch value {
            case let image as UIImage:
               // possibly nil
               return UIImagePNGRepresentation(image).map{
                  pngData in (
                     key: label,
                     value:
                        jsonCompatible
                        ? pngData.base64EncodedString()
                        : pngData
                  )
               }
				
            default:
               // never nil
               return (
                  key: label,
                  value: {
                     switch value {
                     case let value as ConvertibleToSerializableDictionary:
                        return value.makeSerializableDictionary(
                           jsonCompatible: jsonCompatible
                        )
                        
                     case let value as [ConvertibleToSerializableDictionary]:
                        return value.map{
                           $0.makeSerializableDictionary(
										jsonCompatible: jsonCompatible
									)
                        }
                        
                     default: return
                        (value as? CGPoint)?.dictionaryRepresentation
                        ??
								(value as? Date).flatMap{
                           date in
										jsonCompatible
										? date.timeIntervalSinceReferenceDate
										: date
                        }
                        ?? value
                     }
                  }()
					)
            }
         }
		)
		
		return
			key.map{key in [key: serializableDictionary]}
			?? serializableDictionary
	}
	
	func makeJSONData(
		options: JSONSerialization.WritingOptions = [],
		key: String? = nil
	) throws -> Data {
		return try JSONSerialization.data(
			withJSONObject: makeSerializableDictionary(
				jsonCompatible: true,
				key: key
			),
			options: options
		)
	}
	
	func makePropertyListData(
		format: PropertyListSerialization.PropertyListFormat,
		key: String? = nil
	) throws -> Data {
		return try Data(
			propertyList: makeSerializableDictionary(
				jsonCompatible: false,
				key: key
			),
			format: format
		)
	}
}

//MARK:
public extension Sequence
where
	Iterator.Element: ConvertibleToSerializableDictionary,
	Iterator.Element.SerializableDictionaryKey.RawValue == String
{
  func makeJSONData(
    options: JSONSerialization.WritingOptions = [],
    key: String? = nil
  ) throws -> Data {
    return try JSONSerialization.data(
      withJSONObject: self.map{
			$0.makeSerializableDictionary(
				jsonCompatible: true,
				key: key
			)
		},
      options: options
    )
  }
  
  func makePropertyListData(
    format: PropertyListSerialization.PropertyListFormat,
    key: String? = nil
  ) throws -> Data {
    return try PropertyListSerialization.data(
      fromPropertyList: self.map{
			$0.makeSerializableDictionary(
				jsonCompatible: false,
				key: key
			)
		},
      format: format,
      options: .init()
    )
  }
}
