///- Parameter potentialMatches: Static curried methods which take one instance argument, to become instance methods.
///  These represent the options for all the concrete types that `instance` might be.
///
///- Returns: `instance`'s `Method`
public func get_method<
	PotentialInstanceType0,
	PotentialInstanceType1,
	Method
>(
	instance: Any,
	potentialMatches: (
		@noescape (PotentialInstanceType0) -> Method,
		@noescape (PotentialInstanceType1) -> Method
	)
) -> Method? {
	switch instance {
	case let instance as PotentialInstanceType0: return potentialMatches.0(instance)
	case let instance as PotentialInstanceType1: return potentialMatches.1(instance)
	default: return nil
	}
}

///- Parameter potentialMatches: Static curried methods which take one instance argument, to become instance methods.
///  These represent the options for all the concrete types that `instance` might be.
///
///- Returns: `instance`'s `Method`
public func get_method<
	PotentialInstanceType0,
	PotentialInstanceType1,
	PotentialInstanceType2,
	Method
>(
	instance: Any,
	potentialMatches: (
		@noescape (PotentialInstanceType0) -> Method,
		@noescape (PotentialInstanceType1) -> Method,
		@noescape (PotentialInstanceType2) -> Method
	)
) -> Method? {
	return get_method(
		instance: instance,
		potentialMatches: (
			potentialMatches.0,
			potentialMatches.1
		)
	)	?? instance as? PotentialInstanceType2 ?… potentialMatches.2
}

///- Parameter potentialMatches: Static curried methods which take one instance argument, to become instance methods.
///  These represent the options for all the concrete types that `instance` might be.
///
///- Returns: `instance`'s `Method`
public func get_method<
	PotentialInstanceType0,
	PotentialInstanceType1,
	PotentialInstanceType2,
	PotentialInstanceType3,
	Method
>(
	instance: Any,
	potentialMatches: (
		@noescape (PotentialInstanceType0) -> Method,
		@noescape (PotentialInstanceType1) -> Method,
		@noescape (PotentialInstanceType2) -> Method,
		@noescape (PotentialInstanceType3) -> Method
	)
) -> Method? {
	return get_method(
		instance: instance,
		potentialMatches: (
			potentialMatches.0,
			potentialMatches.1,
			potentialMatches.2
		)
	)	?? instance as? PotentialInstanceType3 ?… potentialMatches.3
}

///- Parameter potentialMatches: Static curried methods which take one instance argument, to become instance methods.
///  These represent the options for all the concrete types that `instance` might be.
///
///- Returns: `instance`'s `Method`
public func get_method<
	PotentialInstanceType0,
	PotentialInstanceType1,
	PotentialInstanceType2,
	PotentialInstanceType3,
	PotentialInstanceType4,
	Method
>(
	instance: Any,
	potentialMatches: (
		@noescape (PotentialInstanceType0) -> Method,
		@noescape (PotentialInstanceType1) -> Method,
		@noescape (PotentialInstanceType2) -> Method,
		@noescape (PotentialInstanceType3) -> Method,
		@noescape (PotentialInstanceType4) -> Method
	)
) -> Method? {
	return get_method(
		instance: instance,
		potentialMatches: (
			potentialMatches.0,
			potentialMatches.1,
			potentialMatches.2,
			potentialMatches.3
		)
	)	?? instance as? PotentialInstanceType4 ?… potentialMatches.4
}

///- Parameter potentialMatches: Static curried methods which take one instance argument, to become instance methods.
///  These represent the options for all the concrete types that `instance` might be.
///
///- Returns: `instance`'s `Method`
public func get_method<
	PotentialInstanceType0,
	PotentialInstanceType1,
	PotentialInstanceType2,
	PotentialInstanceType3,
	PotentialInstanceType4,
	PotentialInstanceType5,
	Method
>(
	instance: Any,
	potentialMatches: (
		@noescape (PotentialInstanceType0) -> Method,
		@noescape (PotentialInstanceType1) -> Method,
		@noescape (PotentialInstanceType2) -> Method,
		@noescape (PotentialInstanceType3) -> Method,
		@noescape (PotentialInstanceType4) -> Method,
		@noescape (PotentialInstanceType5) -> Method
	)
) -> Method? {
	return get_method(
		instance: instance,
		potentialMatches: (
			potentialMatches.0,
			potentialMatches.1,
			potentialMatches.2,
			potentialMatches.3,
			potentialMatches.4
		)
	)	?? instance as? PotentialInstanceType5 ?… potentialMatches.5
}

///- Parameter potentialMatches: Static curried methods which take one instance argument, to become instance methods.
///  These represent the options for all the concrete types that `instance` might be.
///
///- Returns: `instance`'s `Method`
public func get_method<
	PotentialInstanceType0,
	PotentialInstanceType1,
	PotentialInstanceType2,
	PotentialInstanceType3,
	PotentialInstanceType4,
	PotentialInstanceType5,
	PotentialInstanceType6,
	Method
>(
	instance: Any,
	potentialMatches: (
		@noescape (PotentialInstanceType0) -> Method,
		@noescape (PotentialInstanceType1) -> Method,
		@noescape (PotentialInstanceType2) -> Method,
		@noescape (PotentialInstanceType3) -> Method,
		@noescape (PotentialInstanceType4) -> Method,
		@noescape (PotentialInstanceType5) -> Method,
		@noescape (PotentialInstanceType6) -> Method
	)
) -> Method? {
	return get_method(
		instance: instance,
		potentialMatches: (
			potentialMatches.0,
			potentialMatches.1,
			potentialMatches.2,
			potentialMatches.3,
			potentialMatches.4,
			potentialMatches.5
		)
	)	?? instance as? PotentialInstanceType6 ?… potentialMatches.6
}
