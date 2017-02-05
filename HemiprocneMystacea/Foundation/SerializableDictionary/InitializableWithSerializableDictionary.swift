public protocol InitializableWithSerializableDictionary {
   init<Dictionary: SerializableDictionary>(
      dictionary: Dictionary
   )
}

public extension Array where Element: InitializableWithSerializableDictionary {
   init<Dictionary: SerializableDictionary>(
      dictionary: Dictionary,
      key: String
   ) throws {
      let dictionaries: [Any] = try dictionary.getValue(key: key)
      self = try dictionaries.map{
         dictionary in Element(
            dictionary: try Dictionary(dictionary: dictionary)
         )
      }
   }
}
