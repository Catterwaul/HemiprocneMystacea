public extension Bool {
	///- Returns:
	/// false for 0,
	/// true for 1,
	/// nil otherwise
	init?(binaryString: String) {
		guard
			let int = Int(binaryString),
			[0, 1].contains(int)
		else {return nil}
		
		self = int == 1
	}
	
	/// Makes true be false and vice versa.
	mutating func toggle() {self = !self}
}

public extension Sequence where Iterator.Element == () -> Bool {
	///- Returns: whether all elements of the sequence evaluate to `bool`
	func containsOnly(_ bool: Bool) -> Bool {
		return self.containsOnly{get_bool in get_bool() == bool}
	}
}
