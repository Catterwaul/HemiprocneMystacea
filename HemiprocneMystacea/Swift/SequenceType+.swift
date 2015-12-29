extension SequenceType {
	func first🔎(@noescape predicate: Generator.Element -> Bool) -> Generator.Element? {
		return self.lazy.filter(predicate).first
	}
   
   @warn_unused_result
   func sorted<Comparable: Swift.Comparable>(@noescape by comparable: Generator.Element -> Comparable)
   -> [Generator.Element] {
      return self.sort{$0•comparable < $1•comparable}
   }
}

infix operator ∀ {}
/// The mathematical symbol meaning "for all".
///- Returns: whether all elements of the sequence satisfy `predicate`
func ∀ <Sequence: SequenceType>(
   sequence: Sequence,
   @noescape predicate: Sequence.Generator.Element -> Bool
) -> Bool {
   return sequence.first🔎{!predicate($0)} == nil
}

extension SequenceType where Generator.Element: Hashable {
    var uniqueElements: [Generator.Element] {
        return Array(Set(self))
    }
}

extension SequenceType where Generator.Element: Equatable {
    var uniqueElements: [Generator.Element] {
        return reduce([]) {uniqueElements, element in
            uniqueElements.contains(element) ? uniqueElements
            : uniqueElements + [element]
        }
    }
}

extension SequenceType where
	Generator.Element: protocol<IntegerLiteralConvertible, IntegerArithmeticType>
{
	var sum: Generator.Element {return self.reduce(0, combine: +)}
}