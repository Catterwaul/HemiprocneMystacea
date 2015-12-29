/// Backing storage for computed properties whose getters and setters will change
struct ComputedProperty<Any> {
	var get: () -> Any
	var set: Any -> ()
}

/// Use this as the getter for set-only properties, 
/// until Swift has real set-only properties.
///- Important: Causes a fatal error, logging the name of the property.
///- Parameter propertyName: Never use this; only use the default.
@noreturn func setOnlyPropertyGetterError(propertyName: String = __FUNCTION__) {
   fatalError("\(propertyName) is set-only")
}