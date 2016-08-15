/// Removes `element` from `array`, if present.
public func -= <Element: Equatable>(
	array: inout [Element],
	element: Element
) {
	guard let index = array.index(of: element)
	else {return}

	array.remove(at: index)
}

/// Removes first element that satisfies `predicate` from `array`,
/// if such an element exists.
public func -=	<Element>(
	array: inout [Element],
	predicate: (Element) -> Bool
) {
	guard let index = array.index(where: predicate)
	else {return}

	array.remove(at: index)
}
