import Foundation

public extension Decimal {
  /// A `Decimal` version of a number, with extraneous floating point digits truncated.
  init<IntegerAndFraction: BinaryFloatingPoint>(
    integerAndFraction: IntegerAndFraction,
    fractionalDigitCount: UInt = 2
  ) {
    self.init(
      sign: integerAndFraction.sign,
      exponent: -Int(fractionalDigitCount),
      significand: Self(Int(
        (integerAndFraction
          * IntegerAndFraction(Self.radix.toThe(fractionalDigitCount))
        ).rounded()
      ))
    )
  }

  var dollarsAndCents: (dollars: Int, cents: Int) {
    (self * 100 as NSDecimalNumber).intValue
      .quotientAndRemainder(dividingBy: 100) as (_, _)
  }
}
