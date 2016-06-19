///- Parameter closure.set: setter for the closure
///
///- Note: *Usage will look like this:*
/// ```
/// closure = nillifyUponCall(closure){closure = $0}
public typealias nillifyUponCall_Closure<Input, Output> = (Input) -> Output
public func nillifyUponCall
<Input, Output>(
   _ closure: nillifyUponCall_Closure<Input, Output>?,
   _ closure_set: (nillifyUponCall_Closure<Input, Output>?) -> ()
) -> nillifyUponCall_Closure<Input, Output>? {
	return closure ?… {closure in
		{input in
			defer {closure_set(nil)}
			return closure(input)
		}
	}
}

//MARK:- nils

///- Returns: Two generic closures which return nil
public func Nils<
   Arguments1, Return1,
   Arguments2, Return2
>() -> (
   (Arguments1) -> Return1?,
   (Arguments2) -> Return2?
) {
   return ({_ in nil}, {_ in nil})
}

///- Returns: - Returns: Three generic closures which return nil
public func Nils<
   Arguments1, Return1,
   Arguments2, Return2,
   Arguments3, Return3
>() -> (
   (Arguments1) -> Return1?,
   (Arguments2) -> Return2?,
   (Arguments3) -> Return3?
) {
   return (
		{_ in nil},
		{_ in nil},
		{_ in nil}
	)
}

///- Returns: - Returns: Four generic closures which return nil
public func Nils<
	Arguments1, Return1,
	Arguments2, Return2,
	Arguments3, Return3,
	Arguments4, Return4
>() -> (
	(Arguments1) -> Return1?,
	(Arguments2) -> Return2?,
	(Arguments3) -> Return3?,
	(Arguments4) -> Return4?
) {
	return (
		{_ in nil},
		{_ in nil},
		{_ in nil},
		{_ in nil}
	)
}
