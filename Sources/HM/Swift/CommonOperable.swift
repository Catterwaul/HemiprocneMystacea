/// A type that can operate with other types via intermediate conversion.
public protocol CommonOperable {
  /// The type to be converted to, for interoperability.
  associatedtype Operand

  init(_: Operand)
  var convertedToOperand: Operand { get }
}

public extension CommonOperable {
  init<Operable: CommonOperable>(_ operable: Operable)
  where Operand == Operable.Operand {
    self.init(operable.convertedToOperand)
  }
}

//MARK: internal
extension CommonOperable {
  /// Forwards  operators to converted operands.
  static func operate<Operable1: CommonOperable, Result>(
    _ operable0: Self,
    _ operate: (Operand, Operand) -> Result,
    _ operable1: Operable1
  ) -> Result
  where Operand == Operable1.Operand {
    operate(
      operable0.convertedToOperand,
      operable1.convertedToOperand
    )
  }

  /// Forwards  `Operand` methods to converted operands.
  func performMethod<Parameter, Result>(
    _ method: (Operand) -> (Parameter) -> Result,
    _ parameter: Parameter
  ) -> Result {
    method(self.convertedToOperand)(parameter)
  }

    /// Forwards  `Operand` methods to converted operands.
  func performMethod<Parameter>(
    _ method: (Operand) -> (Parameter) -> Operand,
    _ parameter: Parameter
  ) -> Self {
    Self( performMethod(method, parameter) as Operand )
  }
}

/// A vector type that can operate with other types via intermediate conversion.
public protocol CommonVectorOperable: CommonOperable
where Operand: SIMD {
  associatedtype Scalar

  static var convertToOperandScalar: (Scalar) -> Operand.Scalar { get }
}

public extension CommonVectorOperable {
  /// Forwards  operators to converted operands.
  static func operate(
    _ vector: Self,
    _ operate: (Operand, Operand.Scalar) -> Operand,
    _ scalar: Scalar
  ) -> Self {
    Self(
      operate(
        vector.convertedToOperand,
        convertToOperandScalar(scalar)
      )
    )
  }
}
