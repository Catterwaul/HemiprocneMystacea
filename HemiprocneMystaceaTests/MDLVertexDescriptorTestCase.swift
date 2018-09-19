import HM
import MetalKit
import XCTest

import simd

final class MDLVertexDescriptorTestCase: XCTestCase {
  func test() {
    XCTAssertEqual(
      MDLVertexDescriptor.makePackedOffsets(
        (size: 12, alignment: 4),
        (size: 12, alignment: 4),
        (size: 8, alignment: 8)
      ),
      [12, 24, 32]
    )
    
    XCTAssertEqual(
      MDLVertexDescriptor.makePackedOffsets(
        (size: 4, alignment: 2),
        (size: 8, alignment: 8)
      ),
      [8, 16]
    )
  }
}
