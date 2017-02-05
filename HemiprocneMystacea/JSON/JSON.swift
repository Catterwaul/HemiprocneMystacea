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
