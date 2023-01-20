#if canImport(UIKit)
import UIKit

public protocol ConvertibleToSerializableDictionary {
  ///- Important: This is a nested type with this signature:
  ///  `enum SerializableDictionaryKey: String`
  associatedtype SerializableDictionaryKey: RawRepresentable
  where SerializableDictionaryKey.RawValue == String
  
  // Should only be defined in the protocol extension,
  // but we can't yet express that `JSONKey.RawValue == String` is always true.
  func makeSerializableDictionary(jsonCompatible: Bool) -> [String: Any]
}

public extension ConvertibleToSerializableDictionary {
  func makeSerializableDictionary(jsonCompatible: Bool) -> [String: Any] {
    makeSerializableDictionary(
      jsonCompatible: jsonCompatible,
      key: nil
    )
  }
	
  func makeSerializableDictionary(
    jsonCompatible: Bool,
    key: String? = nil
  ) -> [String: Any] {
    let serializableDictionary: [String: Any] = Dictionary(
      uniqueKeysWithValues: Mirror(reflecting: self).children.compactMap { child in
        guard
          let label = child.label,
          SerializableDictionaryKey.contains(label),
          let value = .init(flattening: child.value)
        else { return nil }
        
        switch value {
        case let image as UIImage:
          // possibly nil
          return image.pngData().map {
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
//              case let value as ConvertibleToSerializableDictionary:
//                return value.makeSerializableDictionary(
//                  jsonCompatible: jsonCompatible
//                )
//                
//              case let value as [ConvertibleToSerializableDictionary]:
//                return value.map {
//                  $0.makeSerializableDictionary(
//                    jsonCompatible: jsonCompatible
//                  )
//                }
              default:
                return
                  (value as? CGPoint)?.dictionaryRepresentation
                  ??
                  (value as? Date).flatMap { date -> Any in
                    jsonCompatible
                    ? date.timeIntervalSinceReferenceDate
                    : date
                  }
                  ?? value
              }
            } ()
          )
        }
      }
    )
		
		return
			key.map{ key in [key: serializableDictionary] }
			?? serializableDictionary
	}
	
  func makeJSONData(
    options: JSONSerialization.WritingOptions = [],
    key: String? = nil
  ) throws -> Data {
    try JSONSerialization.data(
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
    try Data(
			propertyList: makeSerializableDictionary(
				jsonCompatible: false,
				key: key
			),
			format: format
		)
	}
}

// MARK:
public extension Sequence where Element: ConvertibleToSerializableDictionary {
  func makeJSONData(
    options: JSONSerialization.WritingOptions = [],
    key: String? = nil
  ) throws -> Data {
    try JSONSerialization.data(
      withJSONObject: map {
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
    try PropertyListSerialization.data(
      fromPropertyList: map {
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

#endif
