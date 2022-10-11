public struct SortedArray<Element: Equatable> {
	public typealias GetAreInIncreasingOrder =
		(Element, Element) -> Bool
  
  public private(set) var backingArray: [Element]

  private let getAreInIncreasingOrder: GetAreInIncreasingOrder
}

// MARK: public
public extension SortedArray {
  static func == (
    backedByArray: SortedArray,
    elements: some Sequence<Element>
  ) -> Bool {
    backedByArray.backingArray == .init(elements)
  }

  static func + (
    sortedArray: SortedArray,
    elements: some Sequence<Element>
  ) -> SortedArray {
    .init(
      sortedArray.backingArray + elements,
      getAreInIncreasingOrder: sortedArray.getAreInIncreasingOrder
    )
  }

  static func += (
    backedByArray: inout SortedArray,
    array: [Element]
  ) {
    backedByArray = backedByArray + array
  }

  static func - (
    sortedArray: SortedArray,
    element: Element
  ) -> SortedArray {
    SortedArray(
      sortedArray.backingArray.filter { $0 != element },
      getAreInIncreasingOrder: sortedArray.getAreInIncreasingOrder
    )
  }

  static func -= (
    backedByArray: inout SortedArray,
    element: Element
  ) {
    backedByArray = backedByArray - element
  }

  init(
    _ elements: some Sequence<Element>,
    getAreInIncreasingOrder: @escaping GetAreInIncreasingOrder
  ) {
    backingArray = elements.sorted(by: getAreInIncreasingOrder)
    self.getAreInIncreasingOrder = getAreInIncreasingOrder
  }
}

public extension SortedArray where Element: Comparable {
  init(_ elements: some Sequence<Element>) {
    self.init(
      elements,
      getAreInIncreasingOrder: <
    )
  }
  
  init(_ arrayLiteral: Element...) {
    self.init(arrayLiteral)
  }
}

// MARK: Collection
extension SortedArray: Collection {
  public subscript(index: Int) -> Element {
    backingArray[index]
  }

  public var endIndex: Int { backingArray.endIndex }

  public var startIndex: Int { backingArray.startIndex }

  public func index(after index: Int) -> Int {
    backingArray.index(after: index)
  }
}

// MARK: Sequence
public extension SortedArray {
	func min() -> Element? { backingArray.first }
	func max() -> Element? { backingArray.last }
}
