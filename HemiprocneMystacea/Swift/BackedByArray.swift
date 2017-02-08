/// When you want `Array` to act more like a superclass,
/// use this!
public protocol BackedByArray:
	Collection,
	ExpressibleByArrayLiteral
{
	associatedtype Element = Iterator.Element
	
	init(_: [Element])
	
	/// Don't actually use this directly.
	/// It's only public because protocols
	/// don't have good enough access control yet.
	var backingArray: [Element] {get}
	
	/// Don't actually use this.
	/// It's only public because protocols
	/// don't have good enough access control yet.
	init(backingArray: [Element])
}

//MARK: Collection
public extension BackedByArray {
	subscript(index: Int) -> Element {
		return backingArray[index]
	}
	
	var endIndex: Int {
		return backingArray.endIndex
	}
	
	var startIndex: Int {
		return backingArray.startIndex
	}
	
	func index(after index: Int) -> Int {
		return backingArray.index(after: index)
	}
}

//MARK: ExpressibleByArrayLiteral
public extension BackedByArray {
	init(arrayLiteral: Element...) {
		self.init(arrayLiteral)
	}
}

//MARK: public
public extension BackedByArray {
	static func + <Elements: Sequence>(
		backedByArray: Self,
		elements: Elements
	) -> Self
	where Elements.Iterator.Element == Element {
		return Self(backedByArray.backingArray + elements)
	}
	
	static func += (
		backedByArray: inout Self,
		array: [Element]
	) {
		backedByArray = backedByArray + array
	}
}

public extension BackedByArray where Element: Equatable {
	static func == <Elements: Sequence>(
		backedByArray: Self,
		elements: Elements
	) -> Bool
	where Elements.Iterator.Element == Element {
		return backedByArray.backingArray == Array(elements)
	}

	static func - (
		backedByArray: Self,
		element: Element
	) -> Self {
		return Self(
			backingArray: backedByArray.backingArray.filter{$0 != element}
		)
	}
	
	static func -= (
		backedByArray: inout Self,
		element: Element
	) {
		backedByArray = backedByArray - element
	}
}
