infix operator … {precedence 255}

///- Parameter ƒ: a closure whose argument is `input`
///- Returns: `input`
///- Remark: Hold option, press ;
public func …
<Input>(
	input: Input,
	@noescape ƒ: Input -> ()
) -> Input {
   ƒ(input)
   return input
}

///- Returns: `output(input)`
///- Remark: Hold option, press ;
public func …
<Input, Output>(
	input: Input,
	@noescape output: Input -> Output
) -> Output {
	return output(input)
}

// This results in a Segmentation fault; 
// use it when that's no longer the case.
//public func …<Type>(instances: Type..., recursed: Type -> [Type]) -> [Type]  {
//   return (instances)…(recursed)
//}

/// Recursively get instances via the `recursed` function
public func …
<🃏>(
	instances: [🃏],
	recursed: 🃏 -> [🃏]
) -> [🃏] {
   return instances.flatMap{[$0] + recursed($0)…recursed}
}