import Foundation

public protocol InitializableWithSerializableDictionary {
	init(serializableDictionary: SerializableDictionary) throws
}

public extension InitializableWithSerializableDictionary {
	init(_ dictionary: [String: Any]) throws {
		try self.init(
			serializableDictionary: SerializableDictionary(dictionary)
		)
	}
	
	init(
		jsonData: Data,
		key: String? = nil
	) throws {
		let jsonObject = try JSONSerialization.jsonObject(
			with: jsonData,
			options: .allowFragments
		)
		
		try self.init(
			dictionary: jsonObject,
			key: key
		)
	}
	
	init(
		propertyListData: Data,
		key: String? = nil
	) throws {
		try self.init(
			dictionary:
				try PropertyListSerialization.deserialize(propertyListData)
				.propertyList,
			key: key
		)
	}
	
  // MARK: - private

	private init(
		dictionary: Any,
		key: String? = nil
	) throws {
		guard let dictionary =
      (key.reduce(dictionary as? [String: Any]) { dictionary, key in
        dictionary?[key] as? [String: Any]
      })
    else { throw InitializableWithSerializableDictionaryExtensions.Error.dataNotConvertibleToDictionary }
		
		try self.init(dictionary)
	}
}

// MARK: -

/// A namespace for nested types within `InitializableWithSerializableDictionary`.
public enum InitializableWithSerializableDictionaryExtensions {
  public enum Error: Swift.Error {
    case dataNotConvertibleToDictionary
    case dataNotConvertibleToDictionaries
  }
}

// MARK:
public extension Array where Element: InitializableWithSerializableDictionary {
	private typealias DictionaryArray = [[String: Any]]
	
	init(_ array: [Any]) throws {
		guard let dictionaries = array as? DictionaryArray
		else {
			throw InitializableWithSerializableDictionaryExtensions.Error.dataNotConvertibleToDictionaries
		}
		
		try self.init(dictionaries: dictionaries)
	}
	
  init(
    dictionary: [String: Any],
    key: String
  ) throws {
    try self.init(
      dictionaries: try cast(SerializableDictionary(dictionary)[key]) as DictionaryArray
    )
  }
	
	init(jsonData: Data) throws {
		try self.init(
			deserialized: try JSONSerialization.jsonObject(with: jsonData)
		)
	}
	
	init(propertyListData: Data) throws {
		try self.init(
			deserialized:
				try PropertyListSerialization.deserialize(propertyListData)
				.propertyList
		)
	}
	
  // MARK: - private

  private init(deserialized: Any) throws {
    guard let dictionaries = deserialized as? DictionaryArray
    else { throw InitializableWithSerializableDictionaryExtensions.Error.dataNotConvertibleToDictionaries }

    try self.init(dictionaries: dictionaries)
  }
	
	private init(dictionaries: some Sequence<[String: Any]>) throws {
		self = try
			dictionaries
			.enumerated()
			.mapElements(Element.init)
  }
}
