import struct OrderedCollections.OrderedDictionary

public protocol DictionaryProtocol {
  associatedtype Key
  associatedtype Value
  typealias Element = (key: Key, value: Value)

  init<KeysAndValues: Sequence>(
    _: KeysAndValues,
    uniquingKeysWith: (Value, Value) throws -> Value
  ) rethrows where KeysAndValues.Element == (Key, Value)

  mutating func merge(
    _: some Sequence<(Key, Value)>,
    uniquingKeysWith: (Value, Value) throws -> Value
  ) rethrows
}

extension Dictionary: DictionaryProtocol { }
extension OrderedDictionary: DictionaryProtocol { }

public extension DictionaryProtocol {
  /// `merge`, with labeled tuples.
  ///
  /// - Parameter pairs: Either `KeyValuePairs<Key, Value.Element>`
  ///   or a `Sequence` with the same element type as that.
  @inlinable mutating func merge(
    _ pairs: some Sequence<Element>,
    uniquingKeysWith combine: (Value, Value) throws -> Value
  ) rethrows {
    try merge(pairs.lazy.map(removeLabels), uniquingKeysWith: combine)
  }
}

public extension DictionaryProtocol where Value == Int {
  /// Create "buckets" from a sequence of keys,
  /// such as might be used for a histogram.
  @inlinable init<Keys: Sequence>(bucketing unbucketedKeys: Keys)
  where Keys.Element == Key {
    self.init(zip(unbucketedKeys, 1), uniquingKeysWith: +)
  }
}

// MARK: -

/// Return an unmodified value when uniquing `Dictionary` keys.
public enum PickValue<Value> { }

public extension PickValue {
  /// Keep the original value.
  static var keep: (Value, Value) -> Value {
    { original, _ in original }
  }

  /// Overwrite the original value.
  static var overwrite: (Value, Value) -> Value {
    { $1 }
  }
}

