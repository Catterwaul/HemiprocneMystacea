/// insert
public func += <Set: SetAlgebraType>(inout set: Set, element: Set.Element) {
	set.insert(element)
}

/// remove
public func -= <Set: SetAlgebraType>(inout set: Set, element: Set.Element) {
	set.remove(element)
}

/// intersect
///
/// - Remark: 
///	1. control-command-space
///	2. "interse"
public func ∩ <Set: SetAlgebraType>(left: Set, right: Set) -> Set {
	return left.intersect(right)
}

/// intersect "in place"
///
/// - Remark: 
///	1. control-command-space
///	2. "interse"
public func ∩= <Set: SetAlgebraType>(inout left: Set, right: Set) {
	left.intersectInPlace(right)
}

/// union
///
///- Remark:
/// 1. control-command-space
/// 2. "unio"
public func ∪ <Set: SetAlgebraType>(left: Set, right: Set) -> Set {
	return left.union(right)
}

/// union "in place"
///
///- Remark:
/// 1. control-command-space
/// 2. "unio"
public func ∪= <Set: SetAlgebraType>(inout left: Set, right: Set) {
	left.unionInPlace(right)
}