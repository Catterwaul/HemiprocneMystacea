/// Use this as the getter for set-only properties, 
/// until Swift has real set-only properties.
///- Important: Causes a fatal error, logging the name of the property.
///- Parameter propertyName: Never use this; only use the default.
@noreturn public func setOnlyPropertyGetterError(propertyName: String = #function) {
   fatalError("\(propertyName) is set-only")
}