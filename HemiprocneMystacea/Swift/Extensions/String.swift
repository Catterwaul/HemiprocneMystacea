public extension String {
   ///- Returns: nil if `character` isn't present
	@warn_unused_result
   func after(character: Character) -> String? {
      guard let index = characters.indexOf(character) else {return nil}
      return self.substringFromIndex(index.advancedBy(1))
   }

	@warn_unused_result
   func split(by separator: Character) -> [String] {
      return characters.split(separator).map(String.init)
   }

   ///- Returns: nil if `character` isn't present
   func upTo(character: Character, characterIsIncluded: Bool = false) -> String? {
      guard let index = characters.indexOf(character) else {return nil}
      return self.substringToIndex(
         characterIsIncluded ? index.advancedBy(1) : index
      )
   }
}

/// `_0`, with all occurrences of `_1` removed
@warn_unused_result
public func - (_0: String, _1: String) -> String {
   return _0.stringByReplacingOccurrencesOfString(_1, withString: "")
}

extension SequenceType where Generator.Element == String {
    /// Same as `joinWithSeparator`, but with the empty strings removed
    @warn_unused_result
    public func joined(with separator: String) -> String {
      return self.filter{!$0.isEmpty}.joinWithSeparator(separator)
    }
}

///- Returns: `strings`, concatenated
///- Remark: option-W
@warn_unused_result
public prefix func ∑<Strings: SequenceType where Strings.Generator.Element == String>
(strings: Strings) -> String
{return strings.reduce("", combine: +)}