import typealias OrderedCollections.OrderedDictionary

public protocol DictionaryProtocol<Key, Value>: Sequence where Element == (key: Key, value: Value) {
  associatedtype Key
  associatedtype Keys: Sequence<Key>
  associatedtype Value

  init(uniqueKeysWithValues: some Sequence<(Key, Value)>)

  init(
    _: some Sequence<(Key, Value)>,
    uniquingKeysWith: (Value, Value) throws -> Value
  ) rethrows

  subscript(key: Key) -> Value? { get set }

  var keys: Keys { get }

  mutating func merge(
    _: some Sequence<(Key, Value)>,
    uniquingKeysWith: (Value, Value) throws -> Value
  ) rethrows
}

extension Dictionary: DictionaryProtocol { }
extension OrderedDictionary: DictionaryProtocol { }

public extension DictionaryProtocol {
  // MARK: Initializers

  /// Creates a new dictionary from the key-value pairs in the given sequence.
  ///
  /// - Parameter keysAndValues: A sequence of key-value pairs to use for
  ///   the new dictionary. Every key in `keysAndValues` must be unique.
  /// - Returns: A new dictionary initialized with the elements of `keysAndValues`.
  /// - Precondition: The sequence must not have duplicate keys.
  /// - Note: Differs from the initializer in the standard library, which doesn't allow labeled tuple elements.
  ///     This can't support *all* labels, but it does support `(key:value:)` specifically,
  ///     which `Dictionary` and `KeyValuePairs` use for their elements.
  @inlinable init(uniqueKeysWithValues keysAndValues: some Sequence<Element>) {
    self.init(uniqueKeysWithValues: keysAndValues.lazy.map(removeLabels))
  }

  // MARK: Subscripts

  ///- Returns: nil if `key` is nil
  @inlinable subscript(key: Key?) -> Value? { key.flatMap { self[$0] } }

  @inlinable subscript(
    key: Key,
    valueAddedIfNil value: @autoclosure() -> Value
  ) -> Value {
    mutating get {
      self[key]
      ?? { [value = value()] in
        self[key] = value
        return value
      } ()
    }
  }

  // MARK: Methods

  /// Same values, corresponding to `map`ped keys.
  ///
  /// - Parameter transform: Accepts each key of the dictionary as its parameter
  ///   and returns a key for the new dictionary.
  /// - Postcondition: The collection of transformed keys must not contain duplicates.
  @inlinable func mapKeys<Transformed>(
    _ transform: (Key) throws -> Transformed
  ) rethrows -> [Transformed: Value] {
    .init(
      uniqueKeysWithValues: try map { (try transform($0.key), $0.value) }
    )
  }

  /// Same values, corresponding to `map`ped keys.
  ///
  /// - Parameters:
  ///   - transform: Accepts each key of the dictionary as its parameter
  ///     and returns a key for the new dictionary.
  ///   - combine: A closure that is called with the values for any duplicate
  ///     keys that are encountered. The closure returns the desired value for
  ///     the final dictionary.
  @inlinable func mapKeys<Transformed>(
    _ transform: (Key) throws -> Transformed,
    uniquingKeysWith combine: (Value, Value) throws -> Value
  ) rethrows -> [Transformed: Value] {
    try .init(
      map { (try transform($0.key), $0.value) },
      uniquingKeysWith: combine
    )
  }

  /// `compactMap`ped keys, with their values.
  ///
  /// - Parameter transform: Accepts each key of the dictionary as its parameter
  ///   and returns a potential key for the new dictionary.
  /// - Postcondition: The collection of transformed keys must not contain duplicates.
  @inlinable func compactMapKeys<Transformed>(
    _ transform: (Key) throws -> Transformed?
  ) rethrows -> [Transformed: Value] {
    .init(
      uniqueKeysWithValues: try compactMap { key, value in
        try transform(key).map { ($0, value) }
      }
    )
  }

  /// Same keys, corresponding to `map`ped key-value pairs.
  ///
  /// - Parameter transform: Accepts each element of the dictionary as its parameter
  ///   and returns a transformed value.
  @inlinable func mapToValues<Transformed>(
    _ transform: (Element) throws -> Transformed
  ) rethrows -> [Key: Transformed] {
    .init(
      uniqueKeysWithValues: zip(keys, try map(transform))
    )
  }

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

public extension DictionaryProtocol where Value: Equatable {
  /// The only key that maps to `value`.
  /// - Throws: `OnlyMatchError`
  @inlinable func onlyKey(for value: Value) throws -> Key {
    try onlyMatch { $0.value == value } .key
  }
}

public extension DictionaryProtocol where Value: Sequence {
  /// Flatten value sequences,
  /// pairing each value element with its original key.
  @inlinable func flatMap() -> [(key: Key, value: Value.Element)] {
    flatMap { key, value in value.map { (key, $0) } }
  }
}

public extension DictionaryProtocol where Key == Value {
  /// The longest series of elements that will lead to `destination`.
  /// - Precondition: The elements represent a "`destination:source`" relationship.
  /// - Returns: `nil` if `destination` is not a key in this dictionary.
  func path(to destination: Value) -> (some Sequence<Value>)? {
    self[destination].map { _ in
      sequence(first: destination) { self[$0] }.reversed()
    }
  }
}

public extension DictionaryProtocol where Value == Int {
  /// Create "buckets" from a sequence of keys,
  /// such as might be used for a histogram.
  @inlinable init(bucketing unbucketedKeys: some Sequence<Key>) {
    self.init(zip(unbucketedKeys, 1), uniquingKeysWith: +)
  }
}

// MARK: - 🐞🪲

@available(
  swift, deprecated: 5.8,
  message: "All attempts to move any of this into DictionaryProtocol have failed."
)
public extension Dictionary {
  /// Group key-value pairs by their keys.
  ///
  /// - Parameter pairs: Either `KeyValuePairs<Key, Self.Value.Element>`
  ///   or a `Sequence` with the same element type as that.
  /// - Returns: `[Key: [Value]]`
  init<Value>(grouping pairs: some Sequence<(key: Key, value: Value)>)
  where Self.Value == [Value] {
    self = [_: _](grouping: pairs, by: \.key).mapValues { $0.map(\.value) }
  }

  /// Group key-value pairs by their keys.
  ///
  /// - Parameter pairs: Like `KeyValuePairs<Key, Self.Value.Element>`,
  ///   but with unlabeled elements.
  /// - Returns: `[Key: [Value]]`
  init<Value>(grouping pairs: some Sequence<(Key, Value)>)
  where Self.Value == [Value] {
    self.init( grouping: pairs.lazy.map { (key: $0, value: $1) } )
  }
}

public extension OrderedDictionary {
  /// Group key-value pairs by their keys.
  ///
  /// - Parameter pairs: Either `KeyValuePairs<Key, Self.Value.Element>`
  ///   or a `Sequence` with the same element type as that.
  /// - Returns: `[Key: [Value]]`
  init<Value>(grouping pairs: some Sequence<(key: Key, value: Value)>)
  where Self.Value == [Value] {
    self = OrderedDictionary<_, Array>(grouping: pairs, by: \.key)
      .mapValues { $0.map(\.value) }
  }

  /// Group key-value pairs by their keys.
  ///
  /// - Parameter pairs: Like `KeyValuePairs<Key, Self.Value.Element>`,
  ///   but with unlabeled elements.
  /// - Returns: `[Key: [Value]]`
  init<Value>(grouping pairs: some Sequence<(Key, Value)>)
  where Self.Value == [Value] {
    self.init( grouping: pairs.lazy.map { (key: $0, value: $1) } )
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
