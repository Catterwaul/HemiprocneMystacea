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

// MARK: keyValueThrowingSubscript
extension SerializableDictionary: valueForKeyThrowingAccessor { }
public extension SerializableDictionary {  
  func value<Value>(for key: String) throws -> Value {
    try dictionary.value(for: key)
  }
}
