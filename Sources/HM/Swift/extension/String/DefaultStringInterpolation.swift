public extension DefaultStringInterpolation {
  /// Allow for `static` `String` properties,  which are extensions of `String`,
  /// to use implicit typing via interpolation.
  ///
  /// ```
  /// extension String {
  ///   static let 🧵 = "🧵"
  ///   static let 🧶 = "🧶"
  /// }
  /// ```
  /// ```
  /// "string: \(.🧵) & \(.🧶)" == "string: 🧵 & 🧶"
  /// ```
  /// Do not call this method directly. It is used by the compiler when
  /// interpreting string interpolations.
  @inlinable mutating func appendInterpolation(_ string: String) {
    string.write(to: &self)
  }
}
