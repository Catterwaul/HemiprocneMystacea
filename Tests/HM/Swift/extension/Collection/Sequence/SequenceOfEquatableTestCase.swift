import HM
import XCTest

final class SequenceOfEquatableTestCase: XCTestCase {
//MARK:- firstUniqueElements

  func test_firstUniqueElements_Hashable() {
    XCTAssertEqual(
      [1, 1, 1].firstUniqueElements,
      [1]
    )

    XCTAssertEqual(
      "ABCDEFABCDEFEDCBA".firstUniqueElements,
      ["A", "B", "C", "D", "E", "F"]
    )
  }

  func test_firstUniqueElements_Equatable() {
    struct TypeWith1EquatableProperty: Equatable {
      let int: Int
    }

    let uniqueArray =
      [1, 1, 2, 4, 2, 3, 4]
        .map(TypeWith1EquatableProperty.init)
        .firstUniqueElements
    XCTAssertEqual(
      uniqueArray,
      [1, 2, 4, 3].map(TypeWith1EquatableProperty.init)
    )
  }
}
