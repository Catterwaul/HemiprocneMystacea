import HM
import XCTest

final class ArrayTestCase: XCTestCase {
  func test_init_tuple() {
    XCTAssertEqual(
      Array( mirrorChildValuesOf: (1, 2, 3, 4, 5) ),
      [1, 2, 3, 4, 5]
    )

    XCTAssertNil(
      [Int]( mirrorChildValuesOf: (1, 2, "3", 4, 5) )
    )
  }

  func test_splitInHalf() {
    let intsSplitInHalf = [1, 2, 3, 4, 5].splitInHalf
    
    XCTAssertEqual(intsSplitInHalf[0], [1, 2])
    XCTAssertEqual(intsSplitInHalf[1], [3, 4, 5])
  }
  
  func test_getElement() throws {
    XCTAssertThrowsError( try ["🐾", "🥝"].getElement(index: 2) )
    
    let optionals = [1, 2, nil]
    
    do {
      let optional1 = try optionals.getElement(index: 0)
      XCTAssertEqual(optional1, 1)
    }
    
    let outOfBoundsIndex = optionals.count
    XCTAssertThrowsError(
      try optionals.getElement(index: outOfBoundsIndex)
    ) { error in
      XCTAssert(error is CollectionIndexingError)
    }
  }
}
