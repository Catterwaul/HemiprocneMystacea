///- Parameter closure_set: setter for the closure
///
///- Note: *Usage will look like this:*
/// `nillifyUponCall(closure){closure = $0}`
func nillifyUponCall<In, Out>(
   closure: In -> Out,
   closure_set: (In -> Out)! -> ()
) {
   var closure: (In -> Out)! {
      get {return closure}
      set {closure_set(newValue)}
   }
   closure = nilledUponCall(closure, closure_set)
}

public func nilledUponCall<In, Out>(
   closure: (In -> Out)!,
   _ closure_set: (In -> Out)! -> ()
) -> (In -> Out)! {
   // This stops recursive setting when used in property observers.
   guard let _closure = closure else {return nil}
   
   var closure: (In -> Out)! {
      get {return _closure}
      set {closure_set(newValue)}
   }
   return {
      defer {closure = nil}
      return closure($0)
   }
}