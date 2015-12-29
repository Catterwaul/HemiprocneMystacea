protocol Double🎀 {
	var Double: Swift.Double {get}
}
extension Int: Double🎀 {
   var Double: Swift.Double {return Swift.Double(self)}
}