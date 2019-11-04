import Foundation

extension Measurement: AdditiveArithmetic where UnitType: Dimension {
  public static var zero: Self {
    Self( value: 0, unit: .baseUnit() )
  }

  public static func += (measurement0: inout Self, measurement1: Self) {
    measurement0 = measurement0 + measurement1
  }

  public static func -= (measurement0: inout Self, measurement1: Self) {
    measurement0 = measurement0 - measurement1
  }
}
