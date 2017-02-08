public extension Array where Element: Equatable {
	/// Removes `element` from `array`, if present.
	static func -= (
		array: inout Array,
		element: Element
	) {
		guard let index = array.index(of: element)
		else {return}

		array.remove(at: index)
	}

	/// Removes first element that satisfies `predicate` from `array`,
	/// if such an element exists.
	static func -=	(
		array: inout Array,
		predicate: (Element) -> Bool
	) {
		guard let index = array.index(where: predicate)
		else {return}

		array.remove(at: index)
	}
}
