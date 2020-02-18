public extension FloatingPoint {
  var isInteger: Bool { rounded() == self }
}
