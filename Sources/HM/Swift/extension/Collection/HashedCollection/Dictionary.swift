public extension Dictionary {
  /// Group key-value pairs by their keys.
  ///
  /// - Parameter pairs: Either `Swift.KeyValuePairs<Key, Self.Value.Element>`
  ///   or a `Sequence` with the same element type as that.
  /// - Returns: [ KeyValuePairs.Key: [KeyValuePairs.Value] ]
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
  /// - Returns: [ KeyValuePairs.Key: [KeyValuePairs.Value] ]
  init<Value, KeyValuePairs: Sequence>(grouping pairs: KeyValuePairs)
  where
    KeyValuePairs.Element == (Key, Value),
    Self.Value == [Value]
  {
    self.init( grouping: pairs.map { (key: $0, value: $1) } )
  }

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
  
//MARK: Subscripts
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
}

//MARK:- Operators

//MARK: –
///- Returns: `dictionary`, if its keys that exist in `keysToSetNil` were all set to nil
public func - <
	Key, Value,
	KeysToSetNil: Sequence
>(
	dictionary: [Key: Value],
	keysToSetNil: KeysToSetNil
) -> [Key: Value]
where KeysToSetNil.Element == Key {
  dictionary.filter { !keysToSetNil.contains($0.key) }
}
/// For `dictionary`, assign nil for every key in `keysToSetNil`
public func -= <
	Key, Value,
	KeysToSetNil: Sequence
>(
  dictionary: inout [Key: Value],
	keysToSetNil: KeysToSetNil
)
where KeysToSetNil.Element == Key {
	dictionary = dictionary - keysToSetNil
}
