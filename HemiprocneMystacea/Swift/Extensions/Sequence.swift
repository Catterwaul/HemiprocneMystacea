public extension Sequence {
	func sorted
	<Comparable: Swift.Comparable>
	(by comparable: @noescape (Iterator.Element) -> Comparable) -> [Iterator.Element] {
		return self.sorted{$0…comparable < $1…comparable}
	}
}

extension Sequence where Iterator.Element: protocol<
	IntegerLiteralConvertible,
	IntegerArithmetic
> {
	public var sum: Iterator.Element {
		return self.reduce(0, combine: +)
	}
}

//MARK: containsOnly
public extension Sequence {
	///- Returns: whether all elements of the sequence satisfy `predicate`
	func containsOnly(_ predicate: @noescape (Iterator.Element) -> Bool) -> Bool {
		return !self.contains{!predicate($0)}
	}
}
public extension Sequence where Iterator.Element: Equatable {
	///- Returns: whether all elements of the sequence are equal to `element`
	func containsOnly(_ element: Iterator.Element) -> Bool {
		return self.containsOnly{$0 == element}
	}
}

//MARK: uniqueElements
public extension Sequence where Iterator.Element: Hashable {
  var uniqueElements: [Iterator.Element] {
    return Array(
      Set(self)
    )
  }
}
public extension Sequence where Iterator.Element: Equatable {
  var uniqueElements: [Iterator.Element] {
    return self.reduce([]){uniqueElements, element in
      uniqueElements.contains(element)
				? uniqueElements
				: uniqueElements + [element]
    }
  }
}
