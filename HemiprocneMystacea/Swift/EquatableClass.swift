public protocol EquatableClass: class, Equatable {}

public func == <T: EquatableClass>(lhs: T, rhs: T) -> Bool {
	return lhs === rhs
}