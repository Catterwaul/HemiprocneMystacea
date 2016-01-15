infix operator … {precedence 255}

/// Useful for initializing something and doing 
/// things with it immediately thereafter.
///
///- Parameter instance: Becomes $0 in…
///- Parameter ƒ: the function that uses `instance`.
///
///- Returns: `instance`
///
/// Example:
///```
/// var instance = Type()…{
///    $0.property = newValue
///    $0.doSomething()
/// }
///```
///- Remark: Hold option, press ;
public func …<Type>(
   instance: Type,
   @noescape ƒ: Type -> ()
) -> Type {
   ƒ(instance)
   return instance
}

// This results in a Segmentation fault; 
// use it when that's no longer the case.
//public func …<Type>(instances: Type..., recursed: Type -> [Type]) -> [Type]  {
//   return (instances)…(recursed)
//}

/// Recursively get `Type`s via the `recursed` function
public func …<Type>(instances: [Type], recursed: Type -> [Type]) -> [Type]  {
   return instances.flatMap{[$0] + recursed($0)…recursed}
}