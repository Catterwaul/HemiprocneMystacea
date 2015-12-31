/// insert
public func += <Element>(inout set: Set<Element>, element: Element) {
	set.insert(element)
}

/// remove
public func -= <Element>(inout set: Set<Element>, element: Element) {
	set.remove(element)
}

/// intersect
///
///- Remark:
/// 1. control-command-space
/// 2. "interse"
public func ∩ <Element>(left: Set<Element>, right: Set<Element>) -> Set<Element> {
	return left.intersect(right)
}

/// union
///
///- Remark:
/// 1. control-command-space
/// 2. "unio"
public func ∪ <Element>(left: Set<Element>, right: Set<Element>) -> Set<Element> {
	return left.union(right)
}