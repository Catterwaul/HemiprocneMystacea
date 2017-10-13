///- Parameter reference: An object that is expected to be nil sometimes, when `transform` runs.
///- Parameter transform: A closure whose argument is an unwrapped `Reference?`.
///  It returns a `Transformed`.
///
///- Returns: get for a closure which `transform`s `reference`.
///  This closure will be nil when `reference` is nil
public func makeGet<
	Reference: AnyObject,
	Transformed
>(
	weakReference reference: Reference?,
	transform: @escaping (Reference) -> Transformed
) -> () -> ( () -> Transformed )? {
	return {
		[weak reference] in reference.map {
			reference in {transform(reference)}
		}
	}
}

///- Parameter reference: An object that is expected to be nil sometimes, when `transform` runs.
///- Parameter transform: A closure whose arguments are
///  $0: an unwrapped `Reference?`.
///  $1: a `Parameter`.
///  It returns a `Transformed`.
///
///- Returns: get for a closure that takes a `Parameter` and returns a `Transformed`.
///  This closure will be nil when `reference` is nil
public func makeGet<
	Reference: AnyObject,
	Parameter,
	Transformed
>(
	weakReference reference: Reference?,
	transform: @escaping (Reference, Parameter) -> Transformed
) -> () -> ( (Parameter) -> Transformed )? {
	return {
		[weak reference] in reference.map {
			reference in {transform(reference, $0)}
		}
	}
}
