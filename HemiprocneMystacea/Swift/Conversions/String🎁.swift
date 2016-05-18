private protocol String🎁 {
	func String() -> Swift.String?
}
extension Int: String🎁 {
	public func String() ->  Swift.String? {
		return Swift.String(self)
	}
}