public typealias TuplePlaceholder = Void

public typealias Get<Property> = () throws -> Property

public typealias Process<Processable> = (Processable) -> Void
public typealias ProcessGet<Gettable> = Process< Get<Gettable> >

public typealias Verify = () throws -> Void
public typealias Validate<Parameters> = (Parameters) throws -> Void
