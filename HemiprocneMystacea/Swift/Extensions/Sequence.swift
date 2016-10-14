public extension Sequence {
	var first: Iterator.Element? {
		return self.first{_ in true}
	}
	
	func grouped<Key: Hashable>(
		get_key: (Iterator.Element) -> Key
	) -> [ Key: [Iterator.Element] ] {
		var groups: [ Key: [Iterator.Element] ] = [:]
		
		forEach{
			let key = get_key($0)
			
			if groups[key] == nil {
				groups[key] = [$0]
			}
			else {
				groups[key]!.append($0)
			}
		}
		
		return groups
	}
	
	func sorted<Comparable: Swift.Comparable>(
		get_comparable: (Iterator.Element) -> Comparable
	) -> [Iterator.Element] {
		return self.sorted{
			get_comparable($0) < get_comparable($1)
		}
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
