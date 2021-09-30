/// Acts as a dictionary that `throw`s instead of returning optionals.
public protocol DictionaryLike {
	associatedtype Key
  associatedtype Value

  subscript(key: Key) -> Value? { get }
}

public extension DictionaryLike {
  /// `self[key].unwrapped()`
  subscript<Value>(key: Key) -> Value {
    get throws { try self[key].unwrap() }
  }

  /// Allows lookup by enumeration cases backed by `Key`s,
  /// instead of having to manually use their raw values.
  subscript<Key: RawRepresentable, Value>(key: Key) -> Value
  where Key.RawValue == Self.Key {
    get throws { try self[key.rawValue] }
  }
}
