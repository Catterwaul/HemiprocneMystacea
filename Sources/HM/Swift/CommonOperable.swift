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
  static func operate<Operable1: CommonOperable, Result: CommonOperable>(
    _ operable0: Self,
    _ operate: (Operand, Operand) -> Operand,
    _ operable1: Operable1
  ) -> Result
  where Operand == Operable1.Operand, Operand == Result.Operand {
    Result(
      operate(
        operable0.convertedToOperand,
        operable1.convertedToOperand
      )
    )
  }

  /// Forwards  `Operand` methods to converted operands.
  func performMethod<Parameters, Result: CommonOperable>(
    _ method: (Operand) -> (Parameters) -> Operand,
    _ parameters: Parameters
  ) -> Result
  where Operand == Result.Operand {
    Result( method(self.convertedToOperand)(parameters) )
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
