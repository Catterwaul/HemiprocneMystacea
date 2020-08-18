import Foundation

public extension Measurement where UnitType: Dimension {
  /// The value in terms of `Self.baseUnit`
  var baseValue: Double { value * unit.baseValue }
}

extension Measurement: AdditiveArithmetic where UnitType: Dimension {
  public static var zero: Self {
    .init(value: 0, unit: .baseUnit())
  }
}
