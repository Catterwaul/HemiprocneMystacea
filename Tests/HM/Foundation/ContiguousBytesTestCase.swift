import Foundation
import HM
import XCTest

final class ContiguousBytesTestCase: XCTestCase {
  func test_load() {
    let bytes: [UInt8] = [1, 0, 1, 0]
    XCTAssertEqual(bytes.load() as Int32, 0x1_00_01)
    XCTAssertEqual(bytes.load() as [Int16], [1, 1])
  }
}
