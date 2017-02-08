public struct SortedArray<Element: Comparable>: BackedByArray {
	
//MARK: BackedByArray
	public init(_ unsortedArray: [Element]) {
		backingArray = unsortedArray.sorted()
	}
	
	public init(backingArray: [Element]) {
		self.backingArray = backingArray
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
