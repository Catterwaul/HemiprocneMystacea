public struct SortedArray<Element: Comparable>: BackedByArray {
//MARK: BackedByArray
	public init<Elements: Sequence>(_ elements: Elements)
	where Elements.Iterator.Element == Element {
		backingArray = elements.sorted()
	}

	public fileprivate(set) var backingArray: [Element]
}


//MARK: Sequence
public extension SortedArray {
	func min() -> Element? {
		return backingArray.first
	}
	
	func max() -> Element? {
		return backingArray.last
	}
}
