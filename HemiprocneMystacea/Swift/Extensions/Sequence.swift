public extension Sequence {
	var first: Iterator.Element? {
		return self.first{_ in true}
	}
	
	func grouped<Key: Hashable>(
		get_key: (Iterator.Element) -> Key
	) -> [(
		key: Key,
		group: [Iterator.Element]
	)] {
		let
		keyValuePairs = self.map{(
			key: get_key($0), value: $0
		)},
		uniqueKeys = keyValuePairs.map{$0.key}.uniqueElements
		
		return uniqueKeys.map{
			uniqueKey in (
				key: uniqueKey,
				group: keyValuePairs.filter{uniqueKey == $0.key}
					.map{$0.value}
			)
		}
	}
	
	func sorted<Comparable: Swift.Comparable>(
		by comparable: (Iterator.Element) -> Comparable
	) -> [Iterator.Element] {
		return self.sorted{$0…comparable < $1…comparable}
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
