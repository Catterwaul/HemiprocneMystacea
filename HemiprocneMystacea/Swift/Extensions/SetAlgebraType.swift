extension Set: SetAlgebraType {}

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
///- Remark:
///  1. control-command-space
///  2. "interse"
public func ∩ <Set: SetAlgebraType>(_0: Set, _1: Set) -> Set {
	return _0.intersect(_1)
}

/// intersect "in place"
///
///- Remark:
///  1. control-command-space
///  2. "interse"
public func ∩= <Set: SetAlgebraType>(inout _0: Set, _1: Set) {
	_0.intersectInPlace(_1)
}

/// union
///
///- Remark:
///  1. control-command-space
///  2. "unio"
public func ∪ <Set: SetAlgebraType>(_0: Set, _1: Set) -> Set {
	return _0.union(_1)
}

/// union "in place"
///
///- Remark:
///  1. control-command-space
///  2. "unio"
public func ∪= <Set: SetAlgebraType>(inout _0: Set, _1: Set) {
	_0.unionInPlace(_1)
}