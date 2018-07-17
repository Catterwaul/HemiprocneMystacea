public extension Bool {
	///- Returns:
	/// false for 0,
	/// true for 1,
	/// nil otherwise
	init?(binaryString: String) {
		guard
			let int = Int(binaryString),
			[0, 1].contains(int)
		else { return nil }
		
		self = int == 1
	}
}

public extension Sequence where Element == () -> Bool {
  ///- Returns: whether all elements of the sequence evaluate to `bool`
  func containsOnly(_ bool: Bool) -> Bool {
    return allSatisfy { getBool in bool == getBool() }
  }
}
