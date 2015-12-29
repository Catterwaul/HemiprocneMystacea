protocol Int🎁 {
	var Int: Swift.Int? {get}
}

extension String: Int🎁 {
	var Int: Swift.Int? {return Swift.Int(self)}
	func Int(radix radix: Swift.Int) -> Swift.Int? {
		return Swift.Int(self, radix: radix)
	}
}