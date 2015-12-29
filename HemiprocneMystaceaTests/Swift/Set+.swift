func += <Any>(inout set: Set<Any>, element: Any) {
	set.insert(element)
}

func -= <Any>(inout set: Set<Any>, element: Any) {
	set.remove(element)
}

/// intersect
/// - Remark: 
///	1. control-command-space
///	2. "interse"
func ∩ <Any>(left: Set<Any>, right: Set<Any>) -> Set<Any> {
	return left.intersect(right)
}

/// union
///- Remark:
/// 1. control-command-space
/// 2. "unio"
func ∪ <Any>(left: Set<Any>, right: Set<Any>) -> Set<Any> {
	return left.union(right)
}