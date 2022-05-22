public extension KeyValuePairs {
  /// An error throw from trying to access a value for a key.
  enum AccessError: Error {
    case noValue(key: Key)
    case typeCastFailure(key: Key)
  }
}

public struct KeyValuePair<Key, Value> {
  public var key: Key
  public var value: Value
}

public extension KeyValuePair {
  init(_ keyValuePair: KeyValuePairs<Key, Value>.Element) {
    self.init(key: keyValuePair.key, value: keyValuePair.value)
  }
}

extension KeyValuePair: Equatable where Key: Equatable, Value: Equatable { }
