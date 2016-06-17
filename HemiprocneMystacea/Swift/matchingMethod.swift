/// A solution for utilizing protocol extensions with Objective-C classes,
/// hopefully as an intermediate step to fully translating those classes to Swift.
///
///- Parameter instance: An Objective-C object that, if it had been written in Swift,
///  would be using a protocol extension instead.
///
///- Parameter methods: Static curried methods which take one instance argument, to become instance methods.
///  These represent the options for all the concrete types that `instance` might be.
///
///- Returns: `instance`'s `Method`
public func matchingMethod<
	PotentialInstanceType0,
	PotentialInstanceType1,
	PotentialInstanceType2,
	Method
>(
	instance: Any,
	methods: (
		(PotentialInstanceType0) -> Method,
		(PotentialInstanceType1) -> Method,
		(PotentialInstanceType2) -> Method
	)
) -> Method {
	switch instance {
	case let instance as PotentialInstanceType0: return methods.0(instance)
	case let instance as PotentialInstanceType1: return methods.1(instance)
	case let instance as PotentialInstanceType2: return methods.2(instance)
	default:
		fatalError("None of these are methods of the instance you passed in.")
	}
}
