import Foundation

public extension Dimension {
  /// Create a dimension based on a defined value of similar dimension.
  convenience init(
    _ symbol: String,
    _ value: Double, _ dimension: Dimension
  ) {
    self.init(
      symbol: symbol,
      converter: UnitConverterLinear(coefficient: value * dimension.baseValue)
    )
  }

  /// The value in terms of `Self.baseUnit`
  var baseValue: Double { converter.baseUnitValue(fromValue: 1) }
}
