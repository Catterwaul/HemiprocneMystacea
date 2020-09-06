import HM
import XCTest

final class KeyPathsTestCase: XCTestCase {
  func test_partially_applied_get() {
    let oneTo5 = 1...5
    let keyPath = \(Int, Int).0
    XCTAssert(
      zip(oneTo5, oneTo5).map(keyPath[]).elementsEqual(oneTo5)
    )
  }
  
  func test_get() {
    let keyPath = \Double.isZero
    XCTAssertFalse(keyPath[1.0]())
  }
} 
