private protocol Double🎁 {
	func Double() -> Swift.Double?
}
extension String: Double🎁 {
	public func Double ()-> Swift.Double? {
		return Swift.Double(self)
	}
}