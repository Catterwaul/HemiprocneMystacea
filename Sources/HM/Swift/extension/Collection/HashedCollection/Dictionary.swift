public extension Dictionary {
//MARK:- Operators
  /// Remove key-value pairs for a `Sequence` of `Key`s.
  static func - <KeysToSetNil: Sequence>(
    dictionary: Self, keysToSetNil: KeysToSetNil
  ) -> Self
  where KeysToSetNil.Element == Key {
    keysToSetNil.reduce(into: dictionary) { dictionary, key in
      dictionary[key] = nil
    }
  }
  /// Remove key-value pairs for a `Sequence` of `Key`s.
  static func -= <KeysToSetNil: Sequence>(
    dictionary: inout Self, keysToSetNil: KeysToSetNil
  )
  where KeysToSetNil.Element == Key {
    dictionary = dictionary - keysToSetNil
  }

//MARK:- Subscripts
  ///- Returns: nil if `key` is nil
  subscript(key: Key?) -> Value? { key.flatMap { self[$0] } }

  subscript(
    key: Key,
    valueAddedIfNil getValue: @autoclosure() -> Dictionary.Value
  ) -> Dictionary.Value {
    mutating get {
      self[key]
      ?? {
        self[key] = getValue()
        return self[key]!
      } ()
    }
  }

//MARK:- Initializers
  /// Group key-value pairs by their keys.
  ///
  /// - Parameter pairs: Either `Swift.KeyValuePairs<Key, Self.Value.Element>`
  ///   or a `Sequence` with the same element type as that.
  /// - Returns: `[ KeyValuePairs.Key: [KeyValuePairs.Value] ]`
  init<Value, KeyValuePairs: Sequence>(grouping pairs: KeyValuePairs)
  where
    KeyValuePairs.Element == (key: Key, value: Value),
    Self.Value == [Value]
  {
    self =
      Dictionary<Key, [KeyValuePairs.Element]>(grouping: pairs, by: \.key)
      .mapValues { $0.map(\.value) }
  }

  /// Group key-value pairs by their keys.
  ///
  /// - Parameter pairs: Like `Swift.KeyValuePairs<Key, Self.Value.Element>`,
  ///   but with unlabeled elements.
  /// - Returns: `[ KeyValuePairs.Key: [KeyValuePairs.Value] ]`
  init<Value, KeyValuePairs: Sequence>(grouping pairs: KeyValuePairs)
  where
    KeyValuePairs.Element == (Key, Value),
    Self.Value == [Value]
  {
    self.init( grouping: pairs.map { (key: $0, value: $1) } )
  }

//MARK:- Functions
  /// Same keys, corresponding to `map`ped key-value pairs.
  ///
  /// - Parameter transform: Accepts each element of the dictionary as its parameter
  ///   and returns a transformed value.
  func mapToValues<Transformed>(
    _ transform: (Element) throws -> Transformed
  ) rethrows -> [Key: Transformed] {
    .init(
      uniqueKeysWithValues: zip( keys, try map(transform) )
    )
  }
}
