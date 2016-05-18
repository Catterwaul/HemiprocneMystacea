private protocol Double🎀 {
	func Double() -> Swift.Double
}
extension Int: Double🎀 {
	public func Double ()-> Swift.Double {
		return Swift.Double(self)
	}
}