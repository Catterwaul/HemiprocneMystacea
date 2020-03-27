public struct FibonacciSequence<Number: AdditiveArithmetic & ExpressibleByIntegerLiteral> {
  public init() { }

  private var numbers: (Number, Number) = (0, 1)
}

//MARK: IteratorProtocol, LazySequenceProtocol
extension FibonacciSequence: IteratorProtocol, LazySequenceProtocol {
  public mutating func next() -> Number? {
    defer { numbers = (numbers.1, numbers.0 + numbers.1) }
    return numbers.0
  }
}
