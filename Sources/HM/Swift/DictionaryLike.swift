/// Acts as a dictionary that `throw`s instead of returning optionals.
public protocol DictionaryLike<Key, Value> {
	associatedtype Key
  associatedtype Value

  subscript(key: Key) -> Value? { get }
}

public extension DictionaryLike {
  /// `self[key].unwrap()`
  subscript<Value>(key: Key) -> Value {
    get throws { try self[key].unwrap() }
  }

  /// Allows lookup by enumeration cases backed by `Key`s,
  /// instead of having to manually use their raw values.
  subscript<Value>(key: some RawRepresentable<Key>) -> Value {
    get throws { try self[key.rawValue] }
  }
}
