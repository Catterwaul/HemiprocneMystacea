public func -= <Element: Equatable>(inout array: [Element], element: Element) {
   if let index = array.indexOf(element) {array.removeAtIndex(index)}
}

public func -= <Element>(inout array: [Element], @noescape predicate: Element -> Bool) {
	if let index = array.indexOf(predicate) {array.removeAtIndex(index)}
}