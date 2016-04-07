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

public extension SequenceType where Generator.Element == () -> Bool {
	///- Returns: whether all elements of the sequence evalute to `bool`
   @warn_unused_result
   func containsOnly(bool: Bool) -> Bool {
      return self.containsOnly{$0() == bool}
   }
}