public extension String {
	///- Returns: nil if `character` isn't present
	func after(_ character: Character) -> String? {
		return characters.index(of: character) ?… {
			self.substring(
				from: characters.index(after: $0)
			)
		}
	}

	func split(by separator: Character) -> [String] {
		return characters.split(separator: separator).map(String.init)
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
		return self.reduce("", combine: +)
	}	
}

/// `string0`, with all occurrences of `string1` removed
public func - (
	string0: String,
	string1: String
) -> String {
	return string0.replacingOccurrences(
		of: string1,
		with: ""
	)
}

/// `string`, with all occurrences of each of the `strings` removed
public func -
<Strings: Sequence where Strings.Iterator.Element == String>(
	string: String,
	strings: Strings
) -> String {
	return strings.reduce(string, combine: -)
}
