public extension Dictionary {
//MARK: Initializers
   /// Splats init(dictionaryLiteral elements: (Key, Value)...)
   init
	 <Keys🔗Values: SequenceType where Keys🔗Values.Generator.Element == Element>
   (_ keys🔗values: Keys🔗Values) {
      self.init()
			for (key, value) in keys🔗values {
				self[key] = value
			}
   }
   
	/// SequenceType.Dictionary relies on this
	init
	<Sequence: SequenceType>(
		_ sequence: Sequence,
		_ key🔗value: Sequence.Generator.Element -> (Key, Value)
	) {
		self.init(sequence.map{$0•key🔗value})
	}
	init
	<🃏>(
		_ elements: 🃏...,
		_ key🔗value: 🃏 -> (Key, Value)
	) {
		self.init(
			elements,
			key🔗value
		)
	}
   
//MARK: Subscripts
	///- Returns: nil if `key` is nil
	subscript(key: Key?) -> Value? {
		guard let key = key else {return nil}
		return self[key]
	}

	subscript(
		key: Key,
		@autoclosure valueAddedIfNil Value: () -> Dictionary.Value
	) -> Dictionary.Value {
		mutating get {
			return self[key] ?? {
				self[key] = Value()
				return self[key]!
			}()
		}
	}
}

//MARK: Conversion
public extension SequenceType {
	func Dictionary<Key, Value>(
		key🔗value: Generator.Element -> (Key, Value)
	) -> [Key: Value] {
		return Swift.Dictionary(self, key🔗value)
	}
}

//MARK: Operators
///- Returns: the combination of `dictionary` with a key-value pair sequence
public func + <
	Key,
	Value,
	Keys🔗Values: SequenceType
	where
	Keys🔗Values.Generator.Element == (Key, Value)
>(
	dictionary: Dictionary<Key, Value>,
	keys🔗values: Keys🔗Values
) -> Dictionary<Key, Value> {
	var dictionary = dictionary
	for (key, value) in keys🔗values {
		dictionary[key] = value
	}
	return dictionary
}
/// Combine `dictionary` with a key-value pair sequence
public func += <
	Key,
	Value,
	Keys🔗Values: SequenceType
	where
	Keys🔗Values.Generator.Element == (Key, Value)
>(
	inout dictionary: Dictionary<Key, Value>,
	keys🔗values: Keys🔗Values
) {
   dictionary = dictionary + keys🔗values
}

///- Returns: `dictionary`, if its keys that exist in `keysToSetNil` were all set to nil
public func - <
	Key,
	Value,
	KeysToSetNil: SequenceType
	where
	KeysToSetNil.Generator.Element == Key
>(
	dictionary: Dictionary<Key, Value>,
	keysToSetNil: KeysToSetNil
) -> Dictionary<Key, Value> {
	var dictionary = dictionary
	for key in keysToSetNil {
		dictionary[key] = nil
	}
	return dictionary
}
/// For `dictionary`, assign nil for every key in `keysToSetNil`
public func -= <
	Key,
	Value,
	KeysToSetNil: SequenceType
	where
	KeysToSetNil.Generator.Element == Key
>(
	inout dictionary: Dictionary<Key, Value>,
	keysToSetNil: KeysToSetNil
) {
	dictionary = dictionary - keysToSetNil
}