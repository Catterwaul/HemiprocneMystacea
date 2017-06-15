public struct SortedArray<Element: Equatable>: BackedByArray {
//MARK: public
	public typealias GetAreInIncreasingOrder =
		(Element, Element) -> Bool
	
	public init<Elements: Sequence>(
		_ elements: Elements,
		getAreInIncreasingOrder: @escaping GetAreInIncreasingOrder
	)
	where Elements.Element == Element {
		backingArray = elements.sorted(by: getAreInIncreasingOrder)
		self.getAreInIncreasingOrder = getAreInIncreasingOrder
	}
	
//MARK: private
	private let getAreInIncreasingOrder: GetAreInIncreasingOrder

//MARK: BackedByArray
	public static func + <Elements: Sequence>(
		sortedArray: SortedArray,
		elements: Elements
	) -> SortedArray
	where Elements.Element == Element {
		return SortedArray(
			sortedArray.backingArray + elements,
			getAreInIncreasingOrder: sortedArray.getAreInIncreasingOrder
		)
	}
	
	public static func - (
		sortedArray: SortedArray,
		element: Element
	) -> SortedArray {
		return SortedArray(
			sortedArray.backingArray.filter{$0 != element},
			getAreInIncreasingOrder: sortedArray.getAreInIncreasingOrder
		)
	}
	
	public private(set) var backingArray: [Element]
}

//MARK: public
public extension SortedArray where Element: Comparable {
	init<Elements: Sequence>(_ elements: Elements)
	where Elements.Element == Element {
		self.init(
			elements,
			getAreInIncreasingOrder: <
		)
	}
	
	init(_ arrayLiteral: Element...) {
		self.init(arrayLiteral)
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
