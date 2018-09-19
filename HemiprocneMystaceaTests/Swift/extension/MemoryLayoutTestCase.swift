import HM
import XCTest

final class MemoryLayoutTestCase: XCTestCase {
  func test() {
    let packedFloat3Attributes = (size: 12, alignment: 4)
    XCTAssertEqual(
      getMemoryLayoutOffsets(
        packedFloat3Attributes,
        packedFloat3Attributes,
        (size: 8, alignment: 8)
      ),
      [12, 24, 32]
    )
    
    XCTAssertEqual(
      getMemoryLayoutOffsets(
        (size: 4, alignment: 2),
        (size: 8, alignment: 8)
      ),
      [8, 16]
    )
  }
}
