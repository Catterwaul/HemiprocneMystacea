public extension Dictionary {
//MARK: Initializers
   /// Splats init(dictionaryLiteral elements: (Key, Value)...)
   init
	<Sequence: Swift.Sequence where Sequence.Iterator.Element == Element>
	(_ sequence: Sequence) {
      self.init()
		sequence.forEach{self[$0.key] = $0.value}
   }
	
	init
	<Sequence: Swift.Sequence>(
		_ sequence: Sequence,
		_ transform: (Sequence.Iterator.Element) -> Element
	) {
		self.init(
			sequence.map(transform)
		)
	}
	init
	<Element>(
		_ elements: Element...,
		_ transform: (Element) -> Dictionary.Element
	) {
		self.init(elements, transform)
	}
   
//MARK: Subscripts
	///- Returns: nil if `key` is nil
	subscript(key: Key?) -> Value? {
		return key ?… {self[$0]}
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
	Sequence: Swift.Sequence
	where
	Sequence.Iterator.Element == (
		key: Key,
		value: Value
	)
>(
	dictionary: Dictionary<Key, Value>,
	sequence: Sequence
) -> Dictionary<Key, Value> {
	var dictionary = dictionary
	sequence.forEach{dictionary[$0.key] = $0.value}
	return dictionary
}
/// Combine `dictionary` with a key-value pair sequence
public func += <
	Key, Value,
	Sequence: Swift.Sequence
	where
	Sequence.Iterator.Element == (
		key: Key,
		value: Value
	)
>(
	dictionary: inout Dictionary<Key, Value>,
	sequence: Sequence
) {
   dictionary = dictionary + sequence
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
