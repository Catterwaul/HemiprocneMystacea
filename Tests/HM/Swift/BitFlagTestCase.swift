import HM
import XCTest

final class BitFlagTestCase: XCTestCase {
  func test() throws {
    XCTAssertNil(BitFlag(rawValue: -1))
    XCTAssertNil(BitFlag(rawValue: 0))
    XCTAssertNil(BitFlag(rawValue: 3))
    XCTAssertEqual((0 as BitFlag).rawValue, 1)

    XCTAssertEqual(ShippingOption.standard.rawValue, BitFlag(rawValue: 1 << 4))

    XCTAssertEqual(
      .init(ShippingOption.Set.secondDayPriority),
      [ShippingOption.secondDay, .priority]
    )

    XCTAssertEqual(
      .init(ShippingOption.Set.secondDayPriority.union(.init(.standard))),
      [ShippingOption.secondDay, .priority, .standard]
    )

    XCTAssertEqual(
      [] as [ShippingOption],
      .init([] as ShippingOption.Set)
    )
  }
}

fileprivate enum ShippingOption: BitFlag<Int> {
  case nextDay, secondDay
  // this bit is cursed, don't use it
  case priority = 3, standard
}

fileprivate extension BitFlagRepresentableOptionSet<ShippingOption> {
  // A static property should always return the enclosing type, unless named with a different type.
  // The type of this is ShippingOption.Set. It belongs here, not in `ShippingOption`.
  static let secondDayPriority = Self([ShippingOption.secondDay, .priority])
}
