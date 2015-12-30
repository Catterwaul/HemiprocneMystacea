public func -= <Element: Equatable>(inout left: [Element], right: Element) {
   if let index = left.indexOf(right) {left.removeAtIndex(index)}
}

public func -= <Element>(inout left: [Element], right: Element -> Bool) {
	if let index = left.indexOf(right) {left.removeAtIndex(index)}
}