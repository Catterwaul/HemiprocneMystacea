import Foundation

/// Adds strong typing to treating JSON as a dictionary.
public struct JSON: SerializableDictionary {
	public init(dictionary: Any) throws {    
      self.dictionary = try JSON.makeDictionary(dictionary)
	}
	
   public init(data: Data) throws {
      try self.init(
         dictionary: try JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments
         )
      )
   }
   
   public let dictionary: [String: Any]
}

public extension Data {
   /// - returns: `convertibleToJSON`'s `serializableDictionary` serialized with the "prettyPrinted" option
   init<ConvertibleToJSON: ConvertibleToSerializableDictionary>(
      convertibleToJSON: ConvertibleToJSON
   ) throws {
      try self.init(jsonDictionary: convertibleToJSON.serializableDictionary)
   }
   
   /// - returns: `convertibleToPropertyList` serialized as JSON with the "prettyPrinted" option
   init<ConvertibleToJSON: ConvertibleToSerializableDictionary>(
      key: String,
      convertibleToJSON: ConvertibleToJSON
   ) throws {
      try self.init(
         jsonDictionary: [key: convertibleToJSON.serializableDictionary]
      )
   }
   
   /// - Returns: serialized JSON with the "prettyPrinted" option
   init(jsonDictionary: [String: Any]) throws {
      try self = JSONSerialization.data(
         withJSONObject: jsonDictionary,
         options: .prettyPrinted
      )
   }
}
