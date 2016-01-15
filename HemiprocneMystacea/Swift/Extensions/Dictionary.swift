public extension Dictionary {
//MARK:- Initializers
   /// Splats init(dictionaryLiteral elements: (Key, Value)...)
   init<Keys🔗Values: SequenceType where Keys🔗Values.Generator.Element == Element>
   (_ elements: Keys🔗Values) {
      self.init()
      for element in elements {self[element.0] = element.1}
   }
   
   /// SequenceType.Dictionary relies on this
   init<Sequence: SequenceType>(
      _ sequence: Sequence,
      _ key🔗value: Sequence.Generator.Element -> (Key, Value)
   ) {
      self.init(sequence.map{$0•key🔗value})
   }
   init<Element>(
      _ instances: Element...,
      _ key🔗value: Element -> (Key, Value)
   ) {self.init(instances, key🔗value)}
   
//MARK:- Subscripts
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

//MARK:- Conversion
public extension SequenceType {
   func Dictionary<Key, Value>(
      key🔗value: Generator.Element -> (Key, Value)
   ) -> [Key: Value] {
      return Swift.Dictionary(self, key🔗value)
   }
}

//extension Dictionary where Value: _ArrayType {
//	init(_ values: Value, key_get key: Value.Generator.Element -> Key) {
//		self.init()
//		self = values.reduce(self) {(var `self`, value) in
//			let key = value•key
//			let valuesForKey = `self`[key] ?? Value()
//			`self`[key] = valuesForKey + [value]
//			return `self`
//		}
//	}
//	
//	func 🔒<Key, Value>(🔐: Element -> (Key, Value)) -> [Key: Value] {
//		return self.reduce([Key: Value]()) {(var `self`, keyValuePair) in
//			let keyValuePair = 🔐(keyValuePair)
//			`self`[keyValuePair.0] = keyValuePair.1
//			return `self`
//		}
//	}
//}

//extension _ArrayType {
//	func 🔐<Key>(key: Generator.Element -> Key) -> [Key: Self] {
//		return [Key: Self](self, key_get: key)
//	}
//}

///- Returns: the combination of `dictionary` with a key-value pair sequence
public func + <Key, Value, Keys🔗Values: SequenceType where Keys🔗Values.Generator.Element == (Key, Value)>
(var dictionary: Dictionary<Key, Value>, keys🔗values: Keys🔗Values) -> Dictionary<Key, Value> {
   for (key, value) in keys🔗values {dictionary[key] = value}
	return dictionary
}
/// Combine `dictionary` with a key-value pair sequence
public func += <Key, Value, Keys🔗Values: SequenceType where Keys🔗Values.Generator.Element == (Key, Value)>
(inout dictionary: Dictionary<Key, Value>, keys🔗values: Keys🔗Values) {
   dictionary = dictionary + keys🔗values
}

///- Returns: `dictionary`, if its keys that exist in `keysToSetNil` were all set to nil
public func - <Key, Value, KeysToSetNil: SequenceType where KeysToSetNil.Generator.Element == Key>
(var dictionary: Dictionary<Key, Value>, keysToSetNil: KeysToSetNil) -> Dictionary<Key, Value> {
   for key in keysToSetNil {dictionary[key] = nil}
	return dictionary
}
/// For `dictionary`, assign nil for every key in `keysToSetNil`
public func -= <Key, Value, KeysToSetNil: SequenceType where KeysToSetNil.Generator.Element == Key>
(inout dictionary: Dictionary<Key, Value>, keysToSetNil: KeysToSetNil) {
   dictionary = dictionary - keysToSetNil
}