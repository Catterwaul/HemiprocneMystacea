public struct SortedArray<Element: Comparable>: BackedByArray {
//MARK: BackedByArray
	static func - (
		backedByArray: SortedArray,
		element: Element
	) -> SortedArray {
		return SortedArray(
			backingArray: backedByArray.backingArray.filter{$0 != element}
		)
	}

	public init<Elements: Sequence>(_ elements: Elements)
	where Elements.Iterator.Element == Element {
		backingArray = elements.sorted()
	}

	public fileprivate(set) var backingArray: [Element]
	

//MARK: private
	private init(backingArray: [Element]) {
		self.backingArray = backingArray
	}
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
