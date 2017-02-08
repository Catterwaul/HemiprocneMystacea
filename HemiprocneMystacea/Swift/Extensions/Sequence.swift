public extension Sequence {
	var first: Iterator.Element? {
		return self.first{_ in true}
	}
	
	func grouped<Key: Hashable>(
		getKey: (Iterator.Element) -> Key
	) -> [ Key: [Iterator.Element] ] {
		var groups: [ Key: [Iterator.Element] ] = [:]
		
		forEach{
			let key = getKey($0)
			
			if groups[key] == nil {
				groups[key] = [$0]
			}
			else {
				groups[key]!.append($0)
			}
		}
		
		return groups
	}
	
	func max<Comparable: Swift.Comparable>(
		getComparable: (Iterator.Element) throws -> Comparable
	) rethrows -> Iterator.Element? {
		return try self.max{
			try getComparable($0) < getComparable($1)
		}
	}
	
	func sorted<Comparable: Swift.Comparable>(
		getComparable: (Iterator.Element) -> Comparable
	) -> [Iterator.Element] {
		return self.sorted{getComparable($0) < getComparable($1)}
	}
}

//MARK: containsOnly
public extension Sequence {
	///- Returns: whether all elements of the sequence satisfy `predicate`
	func containsOnly(
		_ predicate: (Iterator.Element) -> Bool
	) -> Bool {
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
		return self.reduce([]){
			uniqueElements, element in
			
			uniqueElements.contains(element)
			? uniqueElements
			: uniqueElements + [element]
	}
	}
}
