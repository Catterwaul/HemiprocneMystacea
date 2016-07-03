///- Parameter reference: An object that is expected to be nil sometimes, when `return` runs.
///- Parameter transform: A closure whose argument is an unwrapped `Reference?`.
///  It returns a `Return`.
///
///- Returns: getter for a closure that returns a `Return`.
///  This closure will be nil when `reference` is nil
public func weakClosure<
	Reference: AnyObject,
	Transformed
>(
	_ reference: Reference?,
	transform: (Reference) -> Transformed
) -> () -> Transformed? {
	return {[weak reference] in
		reference ?… transform
	}
}

///- Parameter reference: An object that is expected to be nil sometimes, when `return` runs.
///- Parameter transform: A closure whose arguments are
///  $0: an unwrapped `Reference?`.
///  $1: a `Parameter`.
///  It returns a `Transformed`.
///
///- Returns: getter for a closure that takes a `Parameter` and returns a `Return`.
///  This closure will be nil when `reference` is nil
public func weakClosure<
	Reference: AnyObject,
	Parameter,
	Transformed
>(
	_ reference: Reference?,
	transform: (Reference, Parameter) -> Transformed
) -> () -> (
	(Parameter) -> Transformed
)? {
	return weakClosure(reference){reference in
		{transform(reference, $0)}
	}
}
