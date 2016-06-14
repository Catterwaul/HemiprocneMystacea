///- Parameter reference: An object that is expected to be nil sometimes, when `return` runs.
///- Parameter return: A closure whose argument is an unwrapped `Reference?`. 
///  It returns a `Return`.
///
///- Returns: getter for a closure that returns a `Return`.
///  This closure will be nil when `reference` is nil
public func weakClosure<
	Reference: AnyObject,
	Return
>(
	reference: Reference?,
	return: Reference -> Return
) -> () -> Return? {
	return {[weak reference] in
		guard let reference = reference
		else {return nil}

		return `return`(reference)
	}
}

///- Parameter reference: An object that is expected to be nil sometimes, when `return` runs.
///- Parameter return: A closure whose arguments are
///  $0: an unwrapped `Reference?`.
///  $1: a `Parameter`.
///  It returns a `Return`.
///
///- Returns: getter for a closure that takes a `Parameter` and returns a `Return`.
///  This closure will be nil when `reference` is nil
public func weakClosure<
	Reference: AnyObject,
	Parameter,
	Return
>(
	reference: Reference?,
	return: (Reference, Parameter) -> Return
) -> () -> (Parameter -> Return)? {
	return weakClosure(reference){reference in
		{`return`(reference, $0)}
	}
}