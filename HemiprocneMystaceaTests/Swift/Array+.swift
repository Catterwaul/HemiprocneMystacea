func -= <Element: Equatable>(inout left: [Element], right: Element) {
	left = left.filter {$0 != right}
}

func -= <T>(inout left: [T], right: T -> Bool) {
	if let index = left.indexOf(right) {left.removeAtIndex(index)}
}