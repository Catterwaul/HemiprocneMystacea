public extension Dictionary {
//MARK: Initializers
	init<Sequence: Swift.Sequence>(
		_ sequence: Sequence,
		_ transform: (Sequence.Element) -> Element
	) {
    self.init( uniqueKeysWithValues: sequence.map(transform) )
	}
	init<Element>(
		_ elements: Element...,
		transform: (Element) -> Dictionary.Element
	) {
		self.init(elements, transform)
	}
   
//MARK: Subscripts
	///- Returns: nil if `key` is nil
	subscript(key: Key?) -> Value? {
		return key.flatMap{self[$0]}
	}

	subscript(
		key: Key,
		valueAddedIfNil getValue: @autoclosure() -> Dictionary.Value
	) -> Dictionary.Value {
		mutating get {
			return
				self[key]
				?? {
					self[key] = getValue()
					return self[key]!
				}()
		}
	}
}

//MARK:- Operators

//MARK: +
///- Returns: the combination of `dictionary` with a key-value pair sequence
public func + <
	Key, Value,
	Sequence: Swift.Sequence
>(
	dictionary: [Key: Value],
	sequence: Sequence
) -> [Key: Value]
where Sequence.Element == (key: Key, value: Value) {
	var dictionary = dictionary
	sequence.forEach{dictionary[$0.key] = $0.value}
	return dictionary
}

/// Combine `dictionary` with a key-value pair sequence
public func += <
	Key, Value,
	Sequence: Swift.Sequence
>(
	dictionary: inout [Key: Value],
	sequence: Sequence
)
where Sequence.Element == (key: Key, value: Value) {
	dictionary = dictionary + sequence
}

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
	var dictionary = dictionary
	for keyToSetNil in keysToSetNil {
		dictionary[keyToSetNil] = nil
	}
	return dictionary
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
