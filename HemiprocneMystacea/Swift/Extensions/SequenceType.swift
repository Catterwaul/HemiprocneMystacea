public extension SequenceType {
   ///- Returns: the first element that satisfies `predicate`
   func first(@noescape predicate: Generator.Element -> Bool)
   -> Generator.Element? {return self.lazy.filter(predicate).first}
   
   ///- Returns: whether all elements of the sequence satisfy `predicate`
   @warn_unused_result
   func obeys(@noescape predicate: Generator.Element -> Bool) -> Bool {
      return !self.contains{!predicate($0)}
   }
   
   @warn_unused_result
   func sorted<Comparable: Swift.Comparable>(
      @noescape by comparable: Generator.Element -> Comparable
   ) -> [Generator.Element] {
      return self.sort{$0•comparable < $1•comparable}
   }
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