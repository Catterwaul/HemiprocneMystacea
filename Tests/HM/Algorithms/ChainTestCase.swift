import HM
import XCTest

final class ChainTestCase: XCTestCase {
  func test_chain() {
    XCTAssert(
      chain("🔗" as Character, "⛓️").elementsEqual("🔗⛓️")
    )
  }

  func test_chainWithoutOverlap() {
    XCTAssertEqual(
      Array(
        chainWithoutOverlap(
          stride(from: 1, to: 10, by: 2),
          (5...15).filter { !$0.isMultiple(of: 2) }
        )
      ),
      .init(
        stride(from: 1, through: 15, by: 2)
      )
    )
  }
}
