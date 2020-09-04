/// Acts as a dictionary.
public protocol valueForKeySubscript: valueForKeyThrowingAccessor {
  associatedtype Value
  
  subscript(key: Key) -> Value? { get }
}

public extension valueForKeySubscript {
  /// - Throws: `KeyValuePairs<Key, Value>.AccessError.noValue`
  func value(for key: Key) throws -> Value {
    try self[key].unwrap(
      orThrow: KeyValuePairs<Key, Value>.AccessError.noValue(key: key)
    )
  }

  /// - Throws: `KeyValuePairs<Key, Value>.AccessError.typeCastFailure`
  func value<Value>(for key: Key) throws -> Value {
    try (value(for: key) as? Value).unwrap(
      orThrow: KeyValuePairs<Key, Value>.AccessError.typeCastFailure(key: key)
    )
  }
}

extension Dictionary: valueForKeySubscript { }

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
