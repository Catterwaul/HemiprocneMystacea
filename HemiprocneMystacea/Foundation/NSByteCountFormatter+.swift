extension NSByteCountFormatter {
	public convenience init(includesUnit: Bool) {
		self.init()
		self.includesUnit = includesUnit
	}

	public func String<Integer: Int64🎀>(byteCount: Integer) -> Swift.String {
		return stringFromByteCount(byteCount.Int64)
	}
}