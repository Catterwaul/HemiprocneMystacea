public protocol Property: class {
	associatedtype Value
	var value: Value {get set}
}