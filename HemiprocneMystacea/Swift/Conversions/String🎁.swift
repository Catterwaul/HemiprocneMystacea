private protocol String🎁 {
	var String: Swift.String? {get}
}
extension Int: String🎁 {
   public var String: Swift.String? {return Swift.String(self)}
}