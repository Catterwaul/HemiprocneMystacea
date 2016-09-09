extension Sequence where Iterator.Element: FloatingPoint {
	public var sum: Iterator.Element {
		return self.reduce(0, +)
	}
}
