infix operator … {precedence 255}

/// Useful for initializing something and doing 
/// things with it immediately thereafter.
///
///- Returns: `💰0`
///
/// Example:
///```
/// var instance = Type()…{
///    $0.property = newValue
///    $0.doSomething()
/// }
///```
///- Remark: Hold option, press ;
public func …
<🃏>(
	💰0: 🃏,
	@noescape ƒ: 🃏 -> ()
) -> 🃏 {
   ƒ(💰0)
   return 💰0
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