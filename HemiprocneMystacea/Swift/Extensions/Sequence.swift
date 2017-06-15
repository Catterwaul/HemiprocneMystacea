public extension Sequence {
  var first: Element? {
    return self.first{_ in true}
  }
  
  func max<Comparable: Swift.Comparable>(
    getComparable: (Element) throws -> Comparable
  ) rethrows -> Element? {
    return try self.max{
      try getComparable($0) < getComparable($1)
    }
  }
  
  func sorted<Comparable: Swift.Comparable>(
    getComparable: (Element) throws -> Comparable
  ) rethrows -> [Element] {
    return try self.sorted{try getComparable($0) < getComparable($1)}
  }
}

//MARK: containsOnly
public extension Sequence {
  ///- Returns: whether all elements of the sequence satisfy `predicate`
  func containsOnly(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
    return try !self.contains{try !predicate($0)}
  }
}

public extension Sequence where Element: Equatable {
  ///- Returns: whether all elements of the sequence are equal to `element`
  func containsOnly(_ element: Element) -> Bool {
    return self.containsOnly{$0 == element}
  }
}

//MARK: uniqueElements
public extension Sequence where Element: Hashable {
	var uniqueElements: [Element] {
		return Array( Set(self) )
	}
}

public extension Sequence where Iterator.Element: Equatable {
	var uniqueElements: [Element] {
		return self.reduce([]){
			uniqueElements, element in
			
			uniqueElements.contains(element)
			? uniqueElements
			: uniqueElements + [element]
		}
	}
}
