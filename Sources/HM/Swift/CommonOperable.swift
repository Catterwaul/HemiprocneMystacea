/// A type that can operate with other types via intermediate conversion.
public protocol CommonOperable<Operand> {
  /// The type to be converted to, for interoperability.
  associatedtype Operand

  init(_: Operand)
  var convertedToOperand: Operand { get }
}

public extension CommonOperable {
  init(_ operable: some CommonOperable<Operand>) {
    self.init(operable.convertedToOperand)
  }
}

// MARK: internal
extension CommonOperable {
  /// Forwards  operators to converted operands.
  static func operate<Result: CommonOperable<Operand>>(
    _ operable0: Self,
    _ operate: (Operand, Operand) -> Operand,
    _ operable1: some CommonOperable<Operand>
  ) -> Result {
    .init(
      operate(
        operable0.convertedToOperand,
        operable1.convertedToOperand
      )
    )
  }

  /// Forwards  `Operand` methods to converted operands.
  func performMethod<Parameters, Result>(
    _ method: (Operand) -> (Parameters) -> Result,
    _ parameters: Parameters
  ) -> Result {
    method(self.convertedToOperand)(parameters)
  }

  /// Forwards  `Operand` methods to converted operands.
  /// - Returns: A converted result.
  func performMethod<Parameters, Result: CommonOperable<Operand>>(
    _ method: (Operand) -> (Parameters) -> Operand,
    _ parameters: Parameters
  ) -> Result {
    .init(performMethod(method, parameters))
  }
}

/// A vector type that can operate with other types via intermediate conversion.
public protocol CommonVectorOperable<Operand>: CommonOperable
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
