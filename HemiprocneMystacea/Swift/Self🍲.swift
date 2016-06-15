/// Utilizes the `InitParameters` tuple for initialization
/// and "matching" with other instances.
public protocol InitParameters {
	associatedtype InitParameters
	
	///- Important: This should be a real initializer,
	/// but conforming types can't override that and call it as `super.init`
	func InitParameters_init(_: InitParameters)
	
	func matches(_: InitParameters) -> Bool
}
