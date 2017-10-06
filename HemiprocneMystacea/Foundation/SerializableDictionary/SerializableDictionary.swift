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
  func getValue<Value>(key: String) throws -> Value {
    guard let anyValue = dictionary[key]
    else {throw GetValueForKeyError.noValue(key: key)}
    
    guard let value = anyValue as? Value
    else {throw GetValueForKeyError.typeCastFailure(key: key)}
    
    return value
  }
}
