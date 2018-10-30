public typealias TuplePlaceholder = Void

public typealias Get<Property> = () throws -> Property

public typealias Verify = () throws -> Void
public typealias Validate<Parameters> = (Parameters) throws -> Void
