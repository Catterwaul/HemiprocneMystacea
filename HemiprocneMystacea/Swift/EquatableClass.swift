public protocol EquatableClass: class, Equatable {}

public func == <Class: EquatableClass>(left: Class, right: Class) -> Bool {
	return left === right
}