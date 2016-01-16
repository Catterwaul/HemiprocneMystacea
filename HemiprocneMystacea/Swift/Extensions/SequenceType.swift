extension SequenceType {
   public func first🔎(@noescape predicate: Generator.Element -> Bool)
   -> Generator.Element? {return self.lazy.filter(predicate).first}
   
   @warn_unused_result
   public func sorted<Comparable: Swift.Comparable>(
      @noescape by comparable: Generator.Element -> Comparable
   ) -> [Generator.Element] {
      return self.sort{$0•comparable < $1•comparable}
   }
}

infix operator ∀ {}
/// The mathematical symbol meaning "for all".
///- Returns: whether all elements of the sequence satisfy `predicate`
///- Remark:
///  1. control-command-space
///  2. "for al"
public func ∀ <Sequence: SequenceType>(
   sequence: Sequence,
   @noescape predicate: Sequence.Generator.Element -> Bool
) -> Bool {
   return !sequence.contains{!predicate($0)}
}

//MARK:- Unique Elements
extension SequenceType where Generator.Element: Hashable {
    public var uniqueElements: [Generator.Element] {
        return Array(Set(self))
    }
}

extension SequenceType where Generator.Element: Equatable {
    public var uniqueElements: [Generator.Element] {
        return reduce([]) {uniqueElements, element in
            uniqueElements.contains(element) ? uniqueElements
            : uniqueElements + [element]
        }
    }
}
//MARK:-

extension SequenceType where
	Generator.Element: protocol<IntegerLiteralConvertible, IntegerArithmeticType>
{
	public var sum: Generator.Element {return self.reduce(0, combine: +)}
}