/// Utilizes the `Parameters` tuple for initialization
/// and "matching" with other instances.
public protocol InitializableWithParameters {
	associatedtype Parameters
	
	///- Important: This should be a real initializer,
	///  but conforming types can't override that and call it as `super.init`
	func InitializableWithParameters_init(_: Parameters)
	
	func matches(_: Parameters) -> Bool
}
