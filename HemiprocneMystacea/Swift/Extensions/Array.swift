/// Removes `element` from `array`, if present.
public func -=
<Element: Equatable>(
	inout array: [Element],
	element: Element
) {
	guard let index = array.indexOf(element)
	else {return}

	array.removeAtIndex(index)
}

/// Removes first element that satisfies `predicate` from `array`,
/// if such an element exists.
public func -=
<Element>(
	inout array: [Element],
	@noescape predicate: Element -> Bool
) {
	guard let index = array.indexOf(predicate)
	else {return}

	array.removeAtIndex(index)
}