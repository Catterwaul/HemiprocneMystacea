import HM
import XCTest

final class BitFlagTestCase: XCTestCase {
  func test() throws {
    XCTAssertNil(BitFlag(rawValue: -1))
    XCTAssertNil(BitFlag(rawValue: 0))
    XCTAssertNil(BitFlag(rawValue: 3))
    XCTAssertEqual((0 as BitFlag).rawValue, 1)

    XCTAssertEqual(ShippingOptions.standard.rawValue, 1 << 4)
  }
}


fileprivate struct ShippingOptions: OptionSet {
  enum Option: BitFlag<Int> {
    case nextDay, secondDay
    // this bit is cursed, don't use it
    case priority = 3, standard
  }

  static let nextDay = Self(Option.nextDay)
  static let secondDay = Self(Option.secondDay)
  static let priority = Self(Option.priority)
  static let standard = Self(Option.standard)

  let rawValue: Int
}
