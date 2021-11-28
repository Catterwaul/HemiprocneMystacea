import HM
import XCTest

final class SequenceOfEquatableTestCase: XCTestCase {
  func test_contains() {
    XCTAssert(
      (-1...10).contains(inOrder: [2, 3, 4])
    )

    XCTAssertFalse(
      (-1...10).contains(inOrder: [2, 4])
    )

    XCTAssertFalse(
      (2...4).contains(inOrder: (-1...5))
    )

    XCTAssertFalse(
      (-1...10).contains(inOrder: EmptyCollection())
    )
  }
  
  func test_containsOnlyUniqueValues() {
    XCTAssert((1...5).containsOnlyUniqueElements)
    XCTAssertFalse(["👯", "👯"].containsOnlyUniqueElements)
  }

  func test_elementsAreAllEqual() {
    XCTAssertNil([Bool]().elementsAreAllEqual)
    XCTAssert([1].elementsAreAllEqual == true)
    XCTAssert(["⭐️", "⭐️"].elementsAreAllEqual == true)
  }

  func test_uniqued_Equatable() {
    struct TypeWith1EquatableProperty: Equatable {
      let int: Int
    }

    let uniqueArray =
      [1, 1, 2, 4, 2, 3, 4]
        .map(TypeWith1EquatableProperty.init)
        .uniqued
    XCTAssertEqual(
      uniqueArray,
      [1, 2, 4, 3].map(TypeWith1EquatableProperty.init)
    )
  }
}

final class SequenceOfHashableTestCase: XCTestCase {
  func test_withKeyedIterations() {
    XCTAssert(
      "abccbaa".withKeyedIterations(of: 1...)
        ==
        [ ("a", 1), ("b", 1), ("c", 1),
          ("c", 2), ("b", 2), ("a", 2),
          ("a", 3)
        ]
    )
  }
}
