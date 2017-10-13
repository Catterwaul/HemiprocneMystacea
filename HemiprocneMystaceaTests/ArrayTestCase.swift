import HM
import XCTest

final class ArrayTestCase: XCTestCase {
  func test_splitInHalf() {
    let intsSplitInHalf = [1, 2, 3, 4, 5].splitInHalf
    
    XCTAssertEqual(intsSplitInHalf[0], [1, 2])
    XCTAssertEqual(intsSplitInHalf[1], [3, 4, 5])
  }
  
  func test_getElement() {
    XCTAssertThrowsError( try ["🐾", "🥝"].getElement(index: 2) )
  }
}
