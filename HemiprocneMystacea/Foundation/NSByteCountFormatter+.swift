extension NSByteCountFormatter {
	convenience init(includesUnit: Bool) {
		self.init()
		self.includesUnit = includesUnit
	}

	func String<Integer: Int64🎀>(byteCount: Integer) -> Swift.String {
		return stringFromByteCount(byteCount.Int64)
	}
}