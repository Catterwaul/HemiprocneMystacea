public extension SequenceType {
	///- Returns: the first element that satisfies `predicate`
	func first(@noescape predicate: Generator.Element -> Bool)
	-> Generator.Element? {
		return self.lazy.filter(predicate).first
	}
	
	@warn_unused_result
	func sorted
	<Comparable: Swift.Comparable>
	(@noescape by comparable: Generator.Element -> Comparable) -> [Generator.Element] {
		return self.sort{$0•comparable < $1•comparable}
	}
}

//MARK: containsOnly
public extension SequenceType {
	///- Returns: whether all elements of the sequence satisfy `predicate`
	@warn_unused_result
	func containsOnly(@noescape predicate: Generator.Element -> Bool) -> Bool {
		return !self.contains{!predicate($0)}
	}
}
public extension SequenceType where Generator.Element: Equatable {
	///- Returns: whether all elements of the sequence are equal to `element`
	@warn_unused_result
	func containsOnly(element: Generator.Element) -> Bool {
		return !self.contains{$0 != element}
	}
}

//MARK:- uniqueElements
public extension SequenceType where Generator.Element: Hashable {
  var uniqueElements: [Generator.Element] {
    return Array(
      Set(self)
    )
  }
}
public extension SequenceType where Generator.Element: Equatable {
  var uniqueElements: [Generator.Element] {
    return self.reduce([]){
      uniqueElements,
      element
    in
      uniqueElements.contains(element)
      ? uniqueElements
      : uniqueElements + [element]
    }
  }
}
//MARK:-

extension SequenceType
where Generator.Element: protocol<
	IntegerLiteralConvertible,
	IntegerArithmeticType
> {
	public var sum: Generator.Element {return self.reduce(0, combine: +)}
}