/// Utilizes the `Self🍲` tuple for initialization 
/// and "matching" with other instances.
public protocol Self🍲 {
	typealias Self🍲
   func matches(self🍲: Self🍲) -> Bool
	func Self_init(self🍲: Self🍲)
}