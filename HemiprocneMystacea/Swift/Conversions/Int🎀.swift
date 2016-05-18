private protocol Int🎀 {
	func Int() -> Swift.Int
}
extension Int64: Int🎀 {
	public func Int() -> Swift.Int {
		return Swift.Int(self)
	}
}