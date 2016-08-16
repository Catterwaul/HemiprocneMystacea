public typealias AsynchronouslyProcess<Processable> = @escaping (Processable) -> Void
public typealias AsynchronouslyProcessThrowingGet<Gettable> = AsynchronouslyProcess<() throws -> Gettable>
public typealias AsynchronouslyVerify = AsynchronouslyProcessThrowingGet<Void>
