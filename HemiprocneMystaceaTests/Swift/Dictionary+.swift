extension Dictionary {
//MARK:- Initializers
   // Splats init(dictionaryLiteral elements: (Key, Value)...)
   public init<KeyValueSequence: SequenceType
      where KeyValueSequence.Generator.Element == Element
   >(_ elements: KeyValueSequence) {
      self.init()
      for element in elements {self[element.0] = element.1}
   }
   
   public init<Sequence: SequenceType>(
      _ sequence: Sequence,
      _ key🔗value: Sequence.Generator.Element -> (Key, Value)
   ) {
      self.init(sequence.map{$0•key🔗value})
   }
   
   public init<Any>(
      _ instances: Any...,
      _ key🔗value: Any -> (Key, Value)
   ) {self.init(instances, key🔗value)}
   
//MARK:- Subscripts
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
extension SequenceType {
   func Dictionary<Key, Value>(
      key🔗value: Generator.Element -> (Key, Value)
   ) -> Swift.Dictionary<Key, Value> {
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


func + <Key, Value, Sequence: SequenceType
   where Sequence.Generator.Element == (Key, Value)
>(var dictionary: Dictionary<Key, Value>, sequence: Sequence) -> Dictionary<Key, Value> {
   for (key, value) in sequence {dictionary[key] = value}
	return dictionary
}
func += <Key, Value, Sequence: SequenceType
   where Sequence.Generator.Element == (Key, Value)
>(inout dictionary: Dictionary<Key, Value>, sequence: Sequence) {
   dictionary = dictionary + sequence
}

func - <Key, Value>(var left: Dictionary<Key, Value>, right: Dictionary<Key, Value>)
-> Dictionary<Key, Value> {
	for key in right.keys {left[key] = nil}
	return left
}
func -= <Key, Value>(inout left: Dictionary<Key, Value>, right: Dictionary<Key, Value>) {
	left = left - right
}