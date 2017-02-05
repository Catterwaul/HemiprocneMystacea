import Foundation

/// Adds strong typing to treating a Property List as a dictionary.
public struct PropertyList: SerializableDictionary {
   public init(dictionary: Any) throws {
      self.dictionary = try PropertyList.makeDictionary(dictionary)
   }
   
   public init(data: Data) throws {
      try self.init(
         dictionary: try PropertyListSerialization.makePropertyList(
            data: data
         )
      )
   }
   
   public init<ConvertibleToPropertyList: ConvertibleToSerializableDictionary>(
      _ convertibleToPropertyList: ConvertibleToPropertyList
   ) throws {
      try self.init(
         data: try Data(convertibleToPropertyList: convertibleToPropertyList)
      )
   }

   public let dictionary: [String: Any]
}

//MARK:
public extension Data {
   /// - returns: `convertibleToPropertyList`'s `serializableDictionary`, serialized
   init<ConvertibleToPropertyList: ConvertibleToSerializableDictionary>(
      convertibleToPropertyList: ConvertibleToPropertyList,
      format: PropertyListSerialization.PropertyListFormat = .xml
   ) throws {
      try self.init(
         propertyListDictionary: convertibleToPropertyList.serializableDictionary,
         format: format
      )
   }
   
   /// - returns: `convertibleToPropertyList`, serialized
   init<ConvertibleToPropertyList: ConvertibleToSerializableDictionary>(
      key: String,
      convertibleToPropertyList: ConvertibleToPropertyList,
      format: PropertyListSerialization.PropertyListFormat = .xml
   ) throws {
      try self.init(
         propertyListDictionary: [key: convertibleToPropertyList.serializableDictionary],
         format: format
      )
   }
   
   /// - Returns: serialized property list
   init(
      propertyListDictionary: [String: Any],
      format: PropertyListSerialization.PropertyListFormat = .xml
   ) throws {
      try self = PropertyListSerialization.data(
         fromPropertyList: propertyListDictionary,
         format: format,
         options: .init()
      )
   }
}
