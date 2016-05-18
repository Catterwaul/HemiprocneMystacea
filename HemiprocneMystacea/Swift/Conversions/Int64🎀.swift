public protocol Int64🎀 {
	func Int64() -> Swift.Int64
}
extension Int64: Int64🎀 {
	public func Int64() -> Swift.Int64 {
		return self
	}
}
extension Int: Int64🎀 {
	public func Int64() -> Swift.Int64 {
		return Swift.Int64(self)
	}
}
extension UInt: Int64🎀 {
	public func Int64() -> Swift.Int64 {
		return Swift.Int64(self)
	}
}
extension UInt64: Int64🎀 {
	public func Int64() -> Swift.Int64 {
		return Swift.Int64(self)
	}
}