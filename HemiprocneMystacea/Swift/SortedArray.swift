public struct SortedArray<Element: Comparable> {
	/// Don't actually use this.
	/// It's only public because protocols
	/// don't have good enough access control yet.
	public var backingArray: [Element]
}

//MARK: ExpressibleByArrayLiteral
extension SortedArray: ExpressibleByArrayLiteral {
	public init(arrayLiteral: Element...) {
		backingArray = arrayLiteral.sorted()
	}
}
