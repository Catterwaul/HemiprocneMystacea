public extension Sequence where Element: Numeric {
  var sum: Element {
    return self.reduce(0, +)
  }
}
