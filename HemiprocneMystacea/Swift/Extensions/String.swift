public extension String {
	///- Returns: nil if `character` isn't present
	func after(_ character: Character) -> String? {
		guard let characterIndex = characters.index(of: character)
		else {return nil}
		
		return self.substring(
			from: characters.index(after: characterIndex)
		)
	}

	func split(by separator: Character) -> [String] {
		return characters.split(separator: separator)
			.map(String.init)
	}

	///- Returns: nil if `character` isn't present
	func upTo(
		_ character: Character,
		characterIsIncluded: Bool = false
	) -> String? {
		guard let index = characters.index(of: character)
		else {return nil}

		return self.substring(
			to: characterIsIncluded
				? characters.index(after: index)
				: index
		)
	}
	
	///- Returns: nil if not prefixed with `prefix`
	func without(prefix: String) -> String? {
		guard self.hasPrefix(prefix)
		else {return nil}
		
		return String(
			characters.dropFirst(prefix.characters.count)
		)
	}
	
	///- Returns: nil if not suffixed with `suffix`
	func without(suffix: String) -> String? {
		guard self.hasSuffix(suffix)
		else {return nil}
		
		return String(
			characters.dropLast(suffix.characters.count)
		)
	}
}

public extension Sequence where Iterator.Element == String {
	var concatenated: String {
		return self.reduce("", +)
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
public func - <Strings: Sequence>
(string: String, strings: Strings) -> String
where Strings.Iterator.Element == String {
	return strings.reduce(string, -)
}
