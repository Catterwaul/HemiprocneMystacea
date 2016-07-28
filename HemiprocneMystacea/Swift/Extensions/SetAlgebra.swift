/// insert
public func += <Set: SetAlgebra>(
	set: inout Set,
	element: Set.Element
) {set.insert(element)}

/// remove
public func -= <Set: SetAlgebra>(
	set: inout Set,
	element: Set.Element
) {set.remove(element)}

/// intersect
///
///- Remark:
///  1. control-command-space
///  2. "interse"
public func ∩ <Set: SetAlgebra>(
	set0: Set,
	set1: Set
) -> Set {return set0.intersection(set1)}

/// intersect "in place"
///
///- Remark:
///  1. control-command-space
///  2. "interse"
public func ∩= <Set: SetAlgebra>(
	set0: inout Set,
	set1: Set
) {set0.formIntersection(set1)}

/// union
///
///- Remark:
///  1. control-command-space
///  2. "unio"
public func ∪ <Set: SetAlgebra>(
	set0: Set,
	set1: Set
) -> Set {return set0.union(set1)}

/// union "in place"
///
///- Remark:
///  1. control-command-space
///  2. "unio"
public func ∪= <Set: SetAlgebra>(
	set0: inout Set,
	set1: Set
) {set0.formUnion(set1)}
