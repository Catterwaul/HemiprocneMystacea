public extension BinaryInteger {
	/// *Divisbility*: when division by `divisor` results in a whole number.
	func divisible(by divisor: Self) -> Bool {
		return self % divisor == 0
	}
}

public extension Sequence where Element: Numeric {
	var sum: Iterator.Element {
		return self.reduce(0, +)
	}
}

public extension Sequence
where Iterator.Element == Int {
  func joined(radix: Int = 10) -> Int? {
    return Int(
      self
        .map{String($0, radix: radix)}
        .joined(),
      radix: radix
    )
  }
}
