private protocol Int🎁 {
	var Int: Swift.Int? {get}
}

extension String: Int🎁 {
	public var Int: Swift.Int? {return Swift.Int(self)}
	public func Int(radix radix: Swift.Int) -> Swift.Int? {
		return Swift.Int(self, radix: radix)
	}
}