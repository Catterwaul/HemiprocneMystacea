public extension String {
	///- Returns: nil if `character` isn't present
	@warn_unused_result
	func after(character: Character) -> String? {
		guard let index = characters.indexOf(character)
		else {return nil}

		return self.substringFromIndex(index.advancedBy(1))
	}

	@warn_unused_result
	func split(by separator: Character) -> [String] {
		return characters.split(separator).map(String.init)
	}

	///- Returns: nil if `character` isn't present
	@warn_unused_result
	func upTo(
		character: Character,
		characterIsIncluded: Bool = false
	) -> String? {
		guard let index = characters.indexOf(character)
		else {return nil}

		return self.substringToIndex(
			characterIsIncluded
				? index.advancedBy(1)
				: index
		)
	}
}

public extension SequenceType where Generator.Element == String {
    var concatenated: String {
        return self.reduce("", combine: +)
    }

	/// Same as `joinWithSeparator`, but with the empty strings removed
	@warn_unused_result
	func joined(with separator: String) -> String {
		return self.filter{!$0.isEmpty}
			.joinWithSeparator(separator)
	}
}

/// `string0`, with all occurrences of `string1` removed
@warn_unused_result
public func - (
	string0: String,
	string1: String
) -> String {
	return string0.stringByReplacingOccurrencesOfString(
		string1,
		withString: ""
	)
}

/// `string`, with all occurrences of each of the `strings` removed
@warn_unused_result
public func -
<Strings: SequenceType where Strings.Generator.Element == String>(
    string: String,
    strings: Strings
) -> String {
    return strings.reduce(string, combine: -)
}