public extension ClosedRange where Bound: AdditiveArithmetic {
  func 🏓(
    by contiguousAdvancement: Bound,
    startingAt start: Bound
  ) -> AnySequence<Bound> {
    guard contains(start)
    else { return .empty }

    var advancement = contiguousAdvancement

    typealias Operate = (Bound, Bound) -> Bound
    var pingPong: Operate = (+)
    var contiguouslyAdvance: Operate = (-)

    return .init(
      sequence(first: start) { previous in
        pingPongIterate: do {
          defer { advancement += contiguousAdvancement }

          let pingPonged = pingPong(previous, advancement)

          guard self.contains(pingPonged)
          else { break pingPongIterate }

          (pingPong, contiguouslyAdvance) = (contiguouslyAdvance, pingPong)
          return pingPonged
        }

        let contiguouslyAdvanced = contiguouslyAdvance(previous, contiguousAdvancement)
        return self.contains(contiguouslyAdvanced)
          ? contiguouslyAdvanced
          : nil
      }
    )
  }
}

public extension ClosedRange where Bound: AdditiveArithmetic & ExpressibleByIntegerLiteral {
  func 🏓(startingAt start: Bound) -> AnySequence<Bound> {
    🏓(by: 1, startingAt: start)
  }
}

public extension ClosedRange where Bound: BinaryInteger {
  func 🏓(by firstAdvancement: Bound = 1) -> AnySequence<Bound> {
    🏓(by: firstAdvancement, startingAt: (upperBound + lowerBound) / 2)
  }
}

public extension ClosedRange where Bound: FloatingPoint {
  func 🏓(by firstAdvancement: Bound = 1) -> AnySequence<Bound> {
    🏓(by: firstAdvancement, startingAt: (upperBound + lowerBound) / 2)
  }
}

//MARK:-

/// A type that can be represented as a `ClosedRange`.
public protocol closedRange {
  associatedtype Bound: Comparable
  var closedRange: ClosedRange<Bound> { get }
}

extension ClosedRange: closedRange {
  public var closedRange: Self { self }
}

extension PartialRangeThrough: closedRange where Bound: ExpressibleByIntegerLiteral {
  /// From zero to the upper bound, inclusive.
  public var closedRange: ClosedRange<Bound> { 0...upperBound }
}

extension PartialRangeUpTo: closedRange
where Bound: ExpressibleByIntegerLiteral & AdditiveArithmetic {
  /// From zero to the upper bound, exclusive.
  public var closedRange: ClosedRange<Bound> { 0...(upperBound - 1) }
}
