///- Parameter closure.set: setter for the closure
///
///- Note: *Usage will look like this:*
/// ```
/// closure = nilledUponCall(closure){closure = $0}
public func nilledUponCall<In, Out>(
   _ closure: ((In) -> Out)!,
   _ closure_set: (((In) -> Out)!) -> ()
) -> ((In) -> Out)! {
   // This stops recursive setting when used in property observers.
   guard let _closure = closure else {return nil}
   
   var closure: ((In) -> Out)! {
      get {return _closure}
      set {closure_set(newValue)}
   }
   return {
      defer {closure = nil}
      return closure($0)
   }
}

///- Parameter closure.set: setter for the closure
///
///- Note: *Usage will look like this:*
///```
/// nillifyUponCall(closure){closure = $0}`
///```
///- Important: You can't use this in a didSet;
///  that would result in infinite recursion.
public func nillifyUponCall<In, Out>(
   _ closure: (In) -> Out,
   closure_set: (((In) -> Out)!) -> ()
) {
   var closure: ((In) -> Out)! {
      get {return closure}
      set {closure_set(newValue)}
   }
   closure = nilledUponCall(closure, closure_set)
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
