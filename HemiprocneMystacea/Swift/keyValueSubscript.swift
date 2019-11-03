/// Acts as a dictionary
public protocol keyValueSubscript: keyValueThrowingSubscript {
	associatedtype Value
	
	subscript(key: Key) -> Value? { get }
}

//MARK: keyValueThrowingSubscript
public extension keyValueSubscript {
  func getValue<Value>(key: Key) throws -> Value {
    guard let uncastValue: Self.Value = self[key]
    else { throw GetValueForKeyError.noValue(key: key) }
    
    guard let value = uncastValue as? Value
    else { throw GetValueForKeyError.typeCastFailure(key: key) }
    
    return value
  }
}

/// Acts as a dictionary that `throw`s instead of returning optionals.
public protocol keyValueThrowingSubscript {
	associatedtype Key
	
	/// Should just be a generic, throwing subscript, but those don't exist yet.
	func getValue<Value>(key: Key) throws -> Value
}

public extension keyValueThrowingSubscript {
	/// Allows lookup by enumeration cases backed by `Key`s,
	/// instead of having to manually use their raw values.
	///
	/// Should just be a generic, throwing subscript, but those don't exist yet.
  func getValue<
    Key: RawRepresentable,
    Value
  >(key: Key) throws -> Value
  where Key.RawValue == Self.Key {
    try self.getValue(key: key.rawValue)
  }
}

public enum GetValueForKeyError<Key>: Error {
  case noValue(key: Key)
  case typeCastFailure(key: Key)
}
