private protocol Int🎁 {
	func Int() -> Swift.Int?
}

extension String: Int🎁 {
	public func Int() -> Swift.Int? {
		return Swift.Int(self)
	}
	
	public func Int(radix radix: Swift.Int) -> Swift.Int? {
		return Swift.Int(self, radix: radix)
	}
}
