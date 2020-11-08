import Foundation
import HM
import XCTest

final class DecimalTestCase: XCTestCase {
  func test_init_integerAndFraction() {
    let string = "-17.01"
    XCTAssertNotEqual("\(-17.01 as Decimal)", string )
    XCTAssertEqual("\(Decimal(integerAndFraction: -17.01))", string)
  }

  func test_dollarsAndCents() {
    XCTAssert(
      (65.321 as Decimal).dollarsAndCents
      == (dollars: 65, cents: 32)
    )
  }
}
