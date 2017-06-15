public extension Sequence where Element: FloatingPoint {
	var sum: Iterator.Element {
		return self.reduce(0, +)
	}
}
