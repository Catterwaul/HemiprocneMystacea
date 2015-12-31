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
public func …<Instance>(
   instance: Instance,
   @noescape ƒ: Instance -> ()
) -> Instance {
   ƒ(instance)
   return instance
}