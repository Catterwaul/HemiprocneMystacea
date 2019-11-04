public extension Sequence where Element: FixedWidthInteger {
  func joined(radix: Int = 10) -> Int? {
    Int(
      map { String($0, radix: radix) } .joined(),
      radix: radix
    )
  }
}
