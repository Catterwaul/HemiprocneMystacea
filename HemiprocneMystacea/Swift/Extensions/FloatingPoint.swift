public extension Sequence where Iterator.Element: FloatingPoint {
	var sum: Iterator.Element {
		return self.reduce(0, +)
	}
}
