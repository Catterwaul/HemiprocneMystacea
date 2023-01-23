import HM
import XCTest

final class FixedWidthIntegerTestCase: XCTestCase {
  func test_PackedInteger_Two() throws {
    let packed = try PackedInteger<Int>.Two(Int32.min, Int32.min)
    XCTAssertEqual(packed.storage.bitPattern, 0x8000_0000_8000_0000)

    XCTAssertThrowsError(
      try PackedInteger<UInt32>.Two<Int32, Int8>(0, 0)
    )

    let unpacked = packed.unpacked
    XCTAssertEqual(unpacked.0, .min)
    XCTAssertEqual(unpacked.1, .min)
  }

  func test_PackedInteger_Three() throws {
    let unpacked =
      try PackedInteger<Int>.Three(Int16.min, Int32.max, Int16.max)
      .unpacked
    XCTAssertEqual(unpacked.0, .min)
    XCTAssertEqual(unpacked.1, .max)
    XCTAssertEqual(unpacked.2, .max)
  }

  func test_PackedInteger_Four() throws {
    let unpacked =
      try PackedInteger<Int32>.Four(Int8.min, UInt8.min, Int8.max, UInt8.max)
      .unpacked
    XCTAssertEqual(unpacked.0, .min)
    XCTAssertEqual(unpacked.1, .min)
    XCTAssertEqual(unpacked.2, .max)
    XCTAssertEqual(unpacked.3, .max)
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

  func test_Nybbles() {
    var integer = 0xABC
    integer.nybbles.swapAt(2, 1)
    XCTAssertEqual(integer, 0xBAC)

    XCTAssertEqual(0x12345.nybbles.sum, 15)
  }

  func test_Bits() {
    var integer = 0b1010
    integer.bits.swapAt(2, 1)
    XCTAssertEqual(integer, 0b1100)

    XCTAssertEqual(0x1010_1111.bits.sum, 6)

    XCTAssertEqual(
      0b1001.afterMitosis,
      0b11_00_00_11
    )
  }
}

fileprivate extension FixedWidthInteger where Self: _ExpressibleByBuiltinIntegerLiteral {
  var afterMitosis: Self {
    bits.enumerated().prefix(4).reduce(0) {
      let clonedBitPair = $1.element | $1.element << 1
      return $0 | clonedBitPair << ($1.offset * 2)
    }
  }
}
