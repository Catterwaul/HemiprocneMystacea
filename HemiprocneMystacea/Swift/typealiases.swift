public typealias TuplePlaceholder = Void

public typealias Process<Processable> = (Processable) -> Void
public typealias ProcessThrowingGet<Gettable> = Process<() throws -> Gettable>
public typealias Verify = ProcessThrowingGet<Void>
