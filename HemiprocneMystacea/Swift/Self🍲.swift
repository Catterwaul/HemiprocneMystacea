/// Utilizes the `Self🍲` tuple for initialization
/// and "matching" with other instances.
public protocol 🍲 {
	associatedtype Self🍲
   
   ///- Important: This should be a real initializer,
   /// but conforming types can't override that and call it as `super.init`
   func Self_init(_: Self🍲)
   
   func matches(_: Self🍲) -> Bool
}