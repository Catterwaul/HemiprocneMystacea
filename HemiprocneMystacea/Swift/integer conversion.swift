protocol Int🎀 {
	var Int: Swift.Int {get}
}
extension Int64: Int🎀 {
   var Int: Swift.Int {return Swift.Int(self)}
}


protocol Int64🎀 {
	var Int64: Swift.Int64 {get}
}
extension Int: Int64🎀 {
	var Int64: Swift.Int64 {return Swift.Int64(self)}
}
extension Int64: Int64🎀 {
	var Int64: Swift.Int64 {return Swift.Int64(self)}
}
extension UInt: Int64🎀 {
	var Int64: Swift.Int64 {return Swift.Int64(self)}
}
extension UInt64: Int64🎀 {
	var Int64: Swift.Int64 {return Swift.Int64(self)}
}