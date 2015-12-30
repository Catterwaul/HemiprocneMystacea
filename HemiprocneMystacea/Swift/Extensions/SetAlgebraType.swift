/// intersect
/// - Remark: 
///	1. control-command-space
///	2. "interse"
func ∩ <Any: SetAlgebraType>(left: Any, right: Any) -> Any {
	return left.intersect(right)
}

/// union
///- Remark:
/// 1. control-command-space
/// 2. "unio"
func ∪ <Any: SetAlgebraType>(left: Any, right: Any) -> Any {
	return left.union(right)
}