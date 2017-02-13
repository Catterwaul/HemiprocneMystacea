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
	
	private init(
		dictionary: Any,
		key: String? = nil
	) throws {
		guard let dictionary: [String: Any] = {
			if let key = key {
				return
					(dictionary as? [String: Any])?[key]
					as? [String: Any]
			}
			return dictionary as? [String: Any]
		}()
		else {throw InitializableWithSerializableDictionaryInitializationError()}
		
		try self.init(dictionary)
	}
}

//MARK: fileprivate
public struct InitializableWithSerializableDictionaryInitializationError: Error {}

public extension Array where Element: InitializableWithSerializableDictionary {
	private typealias DictionaryArray = [ [String: Any] ]
	
	init(_ array: [Any]) throws {
		guard let dictionaries = array as? DictionaryArray
		else {throw InitializableWithSerializableDictionaryInitializationError()}
		
		try self.init(dictionaries: dictionaries)
	}
	
	init(
		dictionary: [String: Any],
		key: String
	) throws {
		try self.init(
			dictionaries:
				try SerializableDictionary(dictionary).getValue(key: key)
				as DictionaryArray
		)
	}
	
	private init<Dictionaries: Sequence>(dictionaries: Dictionaries) throws
	where Dictionaries.Iterator.Element == [String: Any] {
		self = try dictionaries.map{
			dictionary in try Element(dictionary)
		}
	}
}