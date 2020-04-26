/// A type with a static property named `random`.
public protocol random where Self: Comparable {
  static func random(in: ClosedRange<Self>) -> Self
  static var min: Self { get }
  static var max: Self { get }
}

public extension random {
  /// A random value between `min` and `max`, inclusive.
  static var random: Self { random(in: min...max) }
}

extension Int: random { }
extension Int8: random { }
extension Int16: random { }
extension Int32: random { }
extension Int64: random { }
extension UInt: random { }
extension UInt8: random { }
extension UInt16: random { }
extension UInt32: random { }
extension UInt64: random { }
