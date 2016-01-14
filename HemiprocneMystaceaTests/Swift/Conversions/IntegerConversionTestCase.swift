import HemiprocneMystacea
import XCTest

final class IntegerConversionTestCase: XCTestCase {
   func testInt🎀() {
      XCTAssertEqual(Int64(64).Int, 64)
   }
   
   func testInt64🎀() {
      let
         int64: Int64 = 64,
         uInt: UInt = 64,
         uInt64: UInt64 = 64
      XCTAssertEqual(int64.Int64, int64)
      XCTAssertEqual(uInt.Int64, int64)
      XCTAssertEqual(uInt64.Int64, int64)
   }
}