public protocol RangeProtocol<Bound>: RangeExpression {
  func contains(_ range: ClosedRange<Bound>) -> Bool
  func contains(_ range: PartialRangeFrom<Bound>) -> Bool
  func contains(_ range: PartialRangeThrough<Bound>) -> Bool
}

public extension RangeProtocol where Bound: Strideable, Bound.Stride: SignedInteger {
  func contains(_ range: PartialRangeUpTo<Bound>) -> Bool {
    contains(PartialRangeThrough(range))
  }

  func contains(_ range: Range<Bound>) -> Bool {
    contains(ClosedRange(range))
  }
}

public protocol FiniteRange: RangeProtocol { }

public extension FiniteRange {
  func contains(_ range: PartialRangeFrom<Bound>) -> Bool {
    false
  }

  func contains(_ range: PartialRangeThrough<Bound>) -> Bool {
    false
  }

  func contains(_ range: PartialRangeUpTo<Bound>) -> Bool {
    false
  }
}

// MARK: -

extension ClosedRange: RangeProtocol {
  public func contains(_ range: Self) -> Bool {
    contains(range.lowerBound) && contains(range.upperBound)
  }
}

extension ClosedRange: FiniteRange { }

// MARK: -

extension PartialRangeFrom: RangeProtocol {
  public func contains(_ range: ClosedRange<Bound>) -> Bool {
    contains(range.lowerBound)
  }

  public func contains(_ range: Self) -> Bool {
    contains(range.lowerBound)
  }

  public func contains(_ range: PartialRangeThrough<Bound>) -> Bool {
    false
  }
}

public extension PartialRangeFrom {
  func contains(_ range: PartialRangeUpTo<Bound>) -> Bool {
    false
  }

  func contains(_ range: Range<Bound>) -> Bool {
    contains(range.lowerBound)
  }
}

// MARK: -

extension PartialRangeThrough: RangeProtocol {
  public func contains(_ range: ClosedRange<Bound>) -> Bool {
    contains(range.upperBound)
  }

  public func contains(_ range: PartialRangeFrom<Bound>) -> Bool {
    false
  }

  public func contains(_ range: Self) -> Bool {
    contains(range.upperBound)
  }
}

// MARK: -

extension PartialRangeUpTo: RangeProtocol {
  public func contains(_ range: ClosedRange<Bound>) -> Bool {
    contains(range.upperBound)
  }

  public func contains(_ range: PartialRangeFrom<Bound>) -> Bool {
    false
  }

  public func contains(_ range: PartialRangeThrough<Bound>) -> Bool {
    contains(range.upperBound)
  }
}

public extension PartialRangeUpTo {
  func contains(_ range: PartialRangeUpTo<Bound>) -> Bool {
    range.upperBound <= upperBound
  }

  func contains(_ range: Range<Bound>) -> Bool {
    range.upperBound <= upperBound
  }
}

// MARK: -

extension Range: RangeProtocol {
  public func contains(_ range: ClosedRange<Bound>) -> Bool {
    contains(range.lowerBound) && contains(range.upperBound)
  }
}

public extension Range {
  func contains(_ range: Self) -> Bool {
    range.upperBound <= upperBound
  }
}

extension Range: FiniteRange { }
