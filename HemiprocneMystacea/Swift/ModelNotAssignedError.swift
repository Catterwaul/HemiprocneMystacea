public enum ModelNotAssignedError: Error {
  case getAccessor
  case method
}

//MARK: public
public extension ModelNotAssignedError {
  static func makeGetAccessor<Property>() -> () throws -> Property {
    return { throw getAccessor }
  }
  
  static func makeMethod<Return>() -> () throws -> Return {
    return { throw method }
  }
  
  static func makeMethod<Parameters, Return>() -> (Parameters) throws -> Return {
    return { _ in throw method }
  }
}
