import Foundation

public struct SerializableDictionary {
	private let dictionary: [String: Any]
}

//MARK: public
public extension SerializableDictionary {
	init(_ dictionary: [String: Any]) {
		self.dictionary = dictionary
	}
}

//MARK: keyValueThrowingSubscript
extension SerializableDictionary: keyValueThrowingSubscript {}
public extension SerializableDictionary {
	enum GetValueError: Error {
		case noValue(key: String)
		case typeCastFailure(key: String)
	}
	
	func getValue<Value>(key: String) throws -> Value {
      guard let anyValue = dictionary[key]
      else {throw GetValueError.noValue(key: key)}
      
      guard let value = anyValue as? Value
      else {throw GetValueError.typeCastFailure(key: key)}
      
      return value
   }
}
