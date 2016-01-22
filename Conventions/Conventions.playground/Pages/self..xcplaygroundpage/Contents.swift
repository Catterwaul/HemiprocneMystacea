/*:
## When to use explicit “self.”

**Don't use “self.” when it means “my “**

**Use “self.” when it means "I", "me", or "myself"** (_though conjugation maps atrociously..._)
* “myself, filter(ed)” or “me, reduce(d)”
* “I contains(-s)” [from Erica Sadun: The curious case of the self in the night: #swiftlang]

### Examples can be found in:
* SequenceType.swift
* String.swift

[from Erica Sadun: The curious case of the self in the night: #swiftlang]: http://ericasadun.com/2015/08/14/the-curious-case-of-the-self-in-the-night-swiftlang/ ""
*/
import HemiprocneMystacea

/*:
### From SequenceType
*/
public extension SequenceType {
	func first🔎(@noescape predicate: Generator.Element -> Bool)
		-> Generator.Element? {return self.lazy.filter(predicate).first}
	// myself, lazily, filtered
	
	func sorted<Comparable: Swift.Comparable>(
		@noescape by comparable: Generator.Element -> Comparable
		) -> [Generator.Element] {
			return self.sort{$0•comparable < $1•comparable}
			// myself, sorted
	}
}

extension SequenceType where
	Generator.Element: protocol<IntegerLiteralConvertible, IntegerArithmeticType>
{
	public var sum: Generator.Element {return self.reduce(0, combine: +)}
	// myself, reduced
}


/*:
### From String
*/
public extension String {
	func after(character: Character) -> String? {
		guard let index = characters.indexOf(character) else {return nil}
		return self.substringFromIndex(index.advancedBy(1))
		// myself, from index
	}
	
	func upTo(character: Character, characterIsIncluded: Bool = false) -> String? {
		guard let index = characters.indexOf(character) else {return nil}
		return self.substringToIndex(
			characterIsIncluded ? index.advancedBy(1) : index
			// myself, up to index
		)
	}
}

extension SequenceType where Generator.Element == String {
	public func joined(with separator: String) -> String {
		return self.filter{!$0.isEmpty}.joinWithSeparator(separator)
		// myself, filtered
	}
}