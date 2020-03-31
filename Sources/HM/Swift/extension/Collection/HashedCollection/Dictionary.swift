public extension Dictionary {
  init<Value, KeyValuePairs: Sequence>(grouping pairs: KeyValuePairs)
  where
    KeyValuePairs.Element == (Key, Value),
    Self.Value == [Value]
  {
    self =
      Dictionary<Key, [KeyValuePairs.Element]>(grouping: pairs, by: \.0)
      .mapValues { $1.map(\.1) }
  }


  init<Value, KeyValuePairs: Sequence>(grouping pairs: KeyValuePairs)
  where
    KeyValuePairs.Element == (key: Key, value: Value),
    Self.Value == [Value]
  {
    self.init( grouping: pairs.map { ($0, $1) } )
  }

  func mapValues<Transformed>(
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
