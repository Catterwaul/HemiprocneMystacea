import struct Collections.OrderedDictionary

public extension OrderedDictionary {
  /// Group key-value pairs by their keys.
  ///
  /// - Parameter pairs: Either `Swift.KeyValuePairs<Key, Self.Value.Element>`
  ///   or a `Sequence` with the same element type as that.
  /// - Returns: `[KeyValuePairs.Key: [KeyValuePairs.Value]]`
  init<Value, KeyValuePairs: Sequence>(grouping pairs: KeyValuePairs)
  where
    KeyValuePairs.Element == (key: Key, value: Value),
    Self.Value == [Value]
  {
    self =
      OrderedDictionary<Key, [KeyValuePairs.Element]>(grouping: pairs, by: \.key)
      .mapValues { $0.map(\.value) }
  }

  /// Group key-value pairs by their keys.
  ///
  /// - Parameter pairs: Like `Swift.KeyValuePairs<Key, Self.Value.Element>`,
  ///   but with unlabeled elements.
  /// - Returns: `[KeyValuePairs.Key: [KeyValuePairs.Value]]`
  init<Value, KeyValuePairs: Sequence>(grouping pairs: KeyValuePairs)
  where
    KeyValuePairs.Element == (Key, Value),
    Self.Value == [Value]
  {
    self.init( grouping: pairs.map { (key: $0, value: $1) } )
  }
}
