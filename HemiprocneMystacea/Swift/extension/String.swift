public extension String {
	///- Returns: nil if not prefixed with `prefix`
	func without(prefix: String) -> Substring? {
		guard self.hasPrefix(prefix)
		else {return nil}
		
		return self.dropFirst(prefix.count)
	}
	
	///- Returns: nil if not suffixed with `suffix`
	func without(suffix: String) -> Substring? {
		guard self.hasSuffix(suffix)
		else {return nil}
		
		return self.dropLast(suffix.count)
	}
}

/// `string0`, with all occurrences of `string1` removed
public func - (string0: String, string1: String) -> String {
	return string0.replacingOccurrences(
		of: string1,
		with: ""
	)
}

/// `string`, with all occurrences of each of the `strings` removed
public func - <Strings: Sequence>(
	string: String,
	strings: Strings
) -> String
where Strings.Element == String {
	return strings.reduce(string, -)
}
