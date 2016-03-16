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