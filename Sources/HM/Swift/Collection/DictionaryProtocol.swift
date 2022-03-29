import struct OrderedCollections.OrderedDictionary

public protocol DictionaryProtocol {
  associatedtype Key
  associatedtype Value

  init<KeysAndValues: Sequence>(
    _: KeysAndValues,
    uniquingKeysWith: (Value, Value) throws -> Value
  ) rethrows where KeysAndValues.Element == (Key, Value)
}

extension Dictionary: DictionaryProtocol { }
extension OrderedDictionary: DictionaryProtocol { }

public extension DictionaryProtocol where Value == Int {
  /// Create "buckets" from a sequence of keys,
  /// such as might be used for a histogram.
  init<Keys: Sequence>(bucketing unbucketedKeys: Keys)
  where Keys.Element == Key {
    self.init(zip(unbucketedKeys, 1), uniquingKeysWith: +)
  }
}
