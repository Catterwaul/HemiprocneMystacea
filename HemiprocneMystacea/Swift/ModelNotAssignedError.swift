public enum ModelNotAssignedError: Error {
  case getAccessor
  case method
}

//MARK: public
public extension ModelNotAssignedError {
  static func makeGetAccessor<Property>() -> () throws -> Property {
    { throw getAccessor }
  }
  
  static func makeMethod<Return>() -> () throws -> Return {
    { throw method }
  }
  
  static func makeMethod<Parameters, Return>() -> (Parameters) throws -> Return {
    { _ in throw method }
  }
}
