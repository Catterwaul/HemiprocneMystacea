public extension Bool {
	///- Returns: 
	/// false for 0,
	/// true for 1,
	/// nil otherwise
	init?(_ string: String) {
		guard let int = string.Int
		where [0, 1].contains(int)
		else {return nil}
	
		self.init(int)
	}

   /// Makes true be false and vice versa.
   mutating func toggle() {self = !self}
}

public extension SequenceType where Generator.Element == Bool {
	/// Use this directly until conforming to BooleanType is possible.
	var boolValue: Bool {
		return !self.contains{!$0}
	}
}

public extension SequenceType where Generator.Element == () -> Bool {
	/// Use this directly until conforming to BooleanType is possible.
	var boolValue: Bool {
		return !self.contains{!$0()}
	}
}