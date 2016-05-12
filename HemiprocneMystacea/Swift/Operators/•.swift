infix operator • {precedence 255}

/// Used when you'd normally use the dot operator to get a property,
/// but you have to store that operation as a closure for whatever reason.
///
///- Parameter $0: instance on which you'd normally use a dot
///- Parameter property: returns a Property when supplied with an instance
///
///- Returns: the property
///
///- Remark: Hold option, press 8
///
///- Note: Swift's "instance methods" are a lot like this.
///  They're really static methods that take an instance as their first parameter.
public func • <
	🃏,
	Property
>(
	💰0: 🃏,
	@noescape property: (of: 🃏) -> Property
) -> Property {
   return property(of: 💰0)
}