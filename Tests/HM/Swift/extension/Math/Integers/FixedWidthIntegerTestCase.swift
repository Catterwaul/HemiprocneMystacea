import HM
import XCTest

final class FixedWidthIntegerTestCase: XCTestCase {
  func test_unpack() throws {
    let packed = try PackedInteger<Int>.Two<Int32, Int32>(Int32.min, Int32.min)
    XCTAssertEqual(packed.storage.bitPattern, 0x8000_0000_8000_0000)

    XCTAssertThrowsError(
      // The compiler thinks the zeros are `Int`s.
      try PackedInteger<Int>.Two<Int, Int8>(0, 0)
    )

    let unpacked = packed.unpacked
    XCTAssertEqual(unpacked.0, .min)
    XCTAssertEqual(unpacked.1, .min)
  }

  func test_joined() {
    XCTAssertEqual(
      [1, 2].joined(),
      12
    )
    
    XCTAssertEqual(
      [1, 0b10].joined(radix: 0b10),
      0b110
    )
    
    XCTAssertEqual(
      [1, 0x10].joined(radix: 0x10),
      0x110
    )
  }
}
