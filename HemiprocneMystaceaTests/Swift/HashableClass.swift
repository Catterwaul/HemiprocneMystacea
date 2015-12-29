protocol HashableClass: EquatableClass, Hashable {}
extension HashableClass {
	var hashValue: Int {return ObjectIdentifier(self).hashValue}
}