public func += <Any>(inout set: Set<Any>, element: Any) {
	set.insert(element)
}

public func -= <Any>(inout set: Set<Any>, element: Any) {
	set.remove(element)
}

/// intersect
/// - Remark: 
///	1. control-command-space
///	2. "interse"
public func ∩ <Any>(left: Set<Any>, right: Set<Any>) -> Set<Any> {
	return left.intersect(right)
}

/// union
///- Remark:
/// 1. control-command-space
/// 2. "unio"
public func ∪ <Any>(left: Set<Any>, right: Set<Any>) -> Set<Any> {
	return left.union(right)
}