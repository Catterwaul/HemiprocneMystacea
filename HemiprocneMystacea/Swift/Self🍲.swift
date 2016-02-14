/// Utilizes the `Self🍲` tuple for initialization
/// and "matching" with other instances.
public protocol 🍲 {
	typealias Self🍲
   func matches(_: Self🍲) -> Bool
	func Self_init(_: Self🍲)
}