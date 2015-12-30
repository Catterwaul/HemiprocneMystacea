public extension String {
   ///- Returns: nil if `character` isn't present
   func upTo(character: Character, includeTheCharacter: Bool = false) -> String? {
      guard let index = characters.indexOf(character) else {return nil}
      return self.substringToIndex(
         includeTheCharacter ? index.advancedBy(1) : index
      )
   }

   ///- Returns: nil if `character` isn't present
   func after(character: Character) -> String? {
      guard let index = characters.indexOf(character) else {return nil}
      return self.substringFromIndex(index.advancedBy(1))
   }
   
   func split(by separator: Character) -> [String] {
      return characters.split(separator).map(String.init)
   }
}

extension SequenceType where Generator.Element == String {
    /// Same as `joinWithSeparator`, but with the default option to filter empty elements.
    @warn_unused_result
    public func joined(with separator: String, filterEmpties: Bool = true) -> String {
      return filterEmpties ? self.filter{!$0.isEmpty}.joinWithSeparator(separator)
         : self.joinWithSeparator(separator)
    }
}

prefix func ∑<Strings: SequenceType where Strings.Generator.Element == String>
(strings: Strings) -> String
{return strings.reduce("", combine: +)}