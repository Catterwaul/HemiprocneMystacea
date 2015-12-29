protocol String🎁 {
	var String: Swift.String? {get}
}
extension Int: String🎁 {
   var String: Swift.String? {return Swift.String(self)}
}