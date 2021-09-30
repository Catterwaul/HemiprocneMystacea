import Foundation

public struct SerializableDictionary {
	private let dictionary: [String: Any]
}

// MARK: public
public extension SerializableDictionary {
	init(_ dictionary: [String: Any]) {
		self.dictionary = dictionary
	}
}

// MARK: DictionaryLike
extension SerializableDictionary: DictionaryLike {
  public subscript(key: String) -> Any? { dictionary[key] }
}
