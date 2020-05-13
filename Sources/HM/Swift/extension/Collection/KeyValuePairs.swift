public extension KeyValuePairs {
  /// An error throw from trying to access a value for a key.
  enum AccessError: Swift.Error {
    case noValue(key: Key)
    case typeCastFailure(key: Key)
  }
}
