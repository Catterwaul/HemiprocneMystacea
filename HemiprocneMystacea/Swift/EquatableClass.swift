public protocol EquatableClass: class, Equatable {}

public func == <Class: EquatableClass>(
	class0: Class,
	class1: Class
) -> Bool {
	return class0 === class1
}
