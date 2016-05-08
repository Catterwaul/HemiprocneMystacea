extension Set: SetAlgebraType {}

/// insert
public func +=
<Set: SetAlgebraType>(
	inout set: Set,
	element: Set.Element
) {
	set.insert(element)
}

/// remove
public func -=
<Set: SetAlgebraType>(
	inout set: Set,
	element: Set.Element
) {
	set.remove(element)
}

/// intersect
///
///- Remark:
///  1. control-command-space
///  2. "interse"
public func ∩
<Set: SetAlgebraType>(
	💰0: Set,
	💰1: Set
) -> Set {
	return 💰0.intersect(💰1)
}

/// intersect "in place"
///
///- Remark:
///  1. control-command-space
///  2. "interse"
public func ∩=
<Set: SetAlgebraType>(
	inout 💰0: Set,
	💰1: Set
) {
	💰0.intersectInPlace(💰1)
}

/// union
///
///- Remark:
///  1. control-command-space
///  2. "unio"
public func ∪
<Set: SetAlgebraType>(
	💰0: Set,
	💰1: Set
) -> Set {
	return 💰0.union(💰1)
}

/// union "in place"
///
///- Remark:
///  1. control-command-space
///  2. "unio"
public func ∪=
<Set: SetAlgebraType>(
	inout 💰0: Set,
	💰1: Set
) {
	💰0.unionInPlace(💰1)
}