import Foundation

public protocol SerializableDictionary: keyValueThrowingSubscript {
   init(dictionary: Any) throws
   init(data: Data) throws
   
   var dictionary: [String: Any] {get}
   
//MARK: keyValueThrowingSubscript
   typealias Key = String
}

//MARK: internal
extension SerializableDictionary {
   static func makeDictionary(_ dictionary: Any) throws -> [String: Any] {
      guard let dictionary = dictionary as? [String: Any]
      else {throw SerializableDictionaryInitializationError()}
      
      return dictionary
   }
}

//MARK: keyValueThrowingSubscript
public extension SerializableDictionary {
   func getValue<Value>(key: String) throws -> Value {
      guard let anyValue = dictionary[key]
      else {throw Error.noValue(key: key)}
      
      guard let value = anyValue as? Value
      else {throw Error.typeCastFailure(key: key)}
      
      return value
   }
}

//MARK:
public struct SerializableDictionaryInitializationError: Swift.Error {}

private typealias Error = SerializableDictionaryError
public enum SerializableDictionaryError: Swift.Error {
   case noValue(key: String)
   case typeCastFailure(key: String)
}
