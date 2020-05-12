/// Acts as a dictionary.
public protocol valueForKeyAccessor: valueForKeyThrowingAccessor {
	associatedtype Value
	
	subscript(key: Key) -> Value? { get }
}

public extension valueForKeyAccessor {
  /// - Throws: `GetValueForKeyError.noValue`
  func value(for key: Key) throws -> Value {
    guard let value = self[key]
    else { throw GetValueForKeyError.noValue(key: key) }

    return value
  }

  /// - Throws: `GetValueForKeyError`
  func value<Value>(for key: Key) throws -> Value {
    guard let value = try value(for: key) as? Value
    else { throw GetValueForKeyError.typeCastFailure(key: key) }
    
    return value
  }
}

extension Dictionary: valueForKeyAccessor { }

//MARK:-

/// Acts as a dictionary that `throw`s instead of returning optionals.
public protocol valueForKeyThrowingAccessor {
	associatedtype Key
	
	/// Should just be a throwing subscript, but those don't exist yet.
	func value<Value>(for: Key) throws -> Value
}

public extension valueForKeyThrowingAccessor {
	/// Allows lookup by enumeration cases backed by `Key`s,
	/// instead of having to manually use their raw values.
	///
	/// Should just be a generic, throwing subscript, but those don't exist yet.
  func value<Key: RawRepresentable, Value>(for key: Key) throws -> Value
  where Key.RawValue == Self.Key {
    try self.value(for: key.rawValue)
  }
}

//MARK:-

public enum GetValueForKeyError<Key>: Error {
  case noValue(key: Key)
  case typeCastFailure(key: Key)
}
