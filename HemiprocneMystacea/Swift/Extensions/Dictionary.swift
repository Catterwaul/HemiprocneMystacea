public extension Dictionary {
//MARK: Initializers
   /// Splats init(dictionaryLiteral elements: (Key, Value)...)
   init
	<Keys🔗Values: Sequence where Keys🔗Values.Iterator.Element == Element>
   (_ keys🔗values: Keys🔗Values) {
      self.init()
		keys🔗values.forEach{//key, value in
			self[$0.key] = $0.value
		}
   }
   
	/// SequenceType.Dictionary relies on this
	init
	<Sequence: Swift.Sequence>(
		_ sequence: Sequence,
		_ key🔗value: (Sequence.Iterator.Element) -> Element
	) {
		self.init(sequence.map{$0…key🔗value})
	}
	init
	<Element>(
		_ elements: Element...,
		_ key🔗value: (Element) -> Dictionary.Element
	) {
		self.init(
			elements,
			key🔗value
		)
	}
   
//MARK: Subscripts
	///- Returns: nil if `key` is nil
	subscript(key: Key?) -> Value? {
		return key ?… {
			self[$0]
		}
	}

	subscript(
		key: Key,
		valueAddedIfNil value_get: @autoclosure() -> Dictionary.Value
	) -> Dictionary.Value {
		mutating get {
			return self[key] ?? {
				self[key] = value_get()
				return self[key]!
			}()
		}
	}
}

//MARK: Operators
///- Returns: the combination of `dictionary` with a key-value pair sequence
public func + <
	Key, Value,
	Keys🔗Values: Sequence
	where
	Keys🔗Values.Iterator.Element == (key: Key, value: Value)
>(
	dictionary: Dictionary<Key, Value>,
	keys🔗values: Keys🔗Values
) -> Dictionary<Key, Value> {
	var dictionary = dictionary
	keys🔗values.forEach{key, value in
		dictionary[key] = value
	}
	return dictionary
}
/// Combine `dictionary` with a key-value pair sequence
public func += <
	Key, Value,
	Keys🔗Values: Sequence
	where
	Keys🔗Values.Iterator.Element == (key: Key, value: Value)
>(
	dictionary: inout Dictionary<Key, Value>,
	keys🔗values: Keys🔗Values
) {
   dictionary = dictionary + keys🔗values
}

///- Returns: `dictionary`, if its keys that exist in `keysToSetNil` were all set to nil
public func - <
	Key: Hashable, Value,
	KeysToSetNil: Sequence
	where
	KeysToSetNil.Iterator.Element == Key
>(
	dictionary: Dictionary<Key, Value>,
	keysToSetNil: KeysToSetNil
) -> Dictionary<Key, Value> {
	var dictionary = dictionary
	keysToSetNil.forEach{dictionary[$0] = nil}
	return dictionary
}
/// For `dictionary`, assign nil for every key in `keysToSetNil`
public func -= <
	Key: Hashable, Value,
	KeysToSetNil: Sequence
	where
	KeysToSetNil.Iterator.Element == Key
>(
	dictionary: inout Dictionary<Key, Value>,
	keysToSetNil: KeysToSetNil
) {
	dictionary = dictionary - keysToSetNil
}
