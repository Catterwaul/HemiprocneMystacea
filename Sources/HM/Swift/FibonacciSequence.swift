public struct FibonacciSequence<Number: AdditiveArithmetic & ExpressibleByIntegerLiteral> {
  public init() { }

  private var numbers: (Number, Number) = (0, 1)
}

//MARK: Sequence, IteratorProtocol
extension FibonacciSequence: Sequence, IteratorProtocol {
  public mutating func next() -> Number? {
    defer { numbers = (numbers.1, numbers.0 + numbers.1) }
    return numbers.0
  }
}
