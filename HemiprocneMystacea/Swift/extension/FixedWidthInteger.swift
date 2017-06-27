public extension Sequence where Element: FixedWidthInteger {
  func joined(radix: Int = 10) -> Int? {
    return Int(
      self
        .map{String($0, radix: radix)}
        .joined(),
      radix: radix
    )
  }
}
