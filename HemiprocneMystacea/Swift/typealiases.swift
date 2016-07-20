import Foundation

public typealias Process<Processable> = (Processable) -> Void

public typealias ProcessThrowingGet<Value> = Process< Throwing.Get<Value> >

public enum Computed<Value> {}
public extension Computed {
	typealias Get = () -> Value
	typealias Set = (Value) -> Void
}

public enum Throwing {}
public extension Throwing {
	typealias Get<Value> = () throws -> Value
}
