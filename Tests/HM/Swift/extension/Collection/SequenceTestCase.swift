import HM
import XCTest

final class SequenceTestCase: XCTestCase {
   func test_consecutivePairs() {
    XCTAssertTrue(
      Array([1, 3, 9, -44].consecutivePairs)
      ==
      [(1, 3), (3, 9), (9, -44)]
    )
  }

  func test_first() {
    let odds = stride(from: 1, through: 9, by: 2)

    XCTAssertEqual(odds.first, 1)
    XCTAssertNil(odds.prefix(0).first)
  }

  func test_getCount() throws {
    XCTAssertEqual(
      [1, 2, nil].getCount { $0 < 3 },
      2
    )
  }

  func test_max_and_min() {
    let dictionary = [
      "1️⃣": 1,
      "🔟": 10,
      "💯": 100
    ]
    
    XCTAssertEqual(
      dictionary.max(\.value)!.key,
      "💯"
    )
    
    XCTAssertEqual(
      dictionary.min(\.value)!.key,
      "1️⃣"
    )
  }

  func test_max_and_min_withOptionals() {
    let catNames = [
      nil, "Frisky", nil, "Fluffy", nil,
      nil, "Gobo", nil,
      nil, "Mousse", nil, "Ozma", nil
    ]

    XCTAssertEqual(catNames.min { $0 }, "Fluffy")
    XCTAssertEqual(catNames.max { $0 }, "Ozma")
  }
	
  func test_sortedBy() {
    let sortedArray = [
      TypeWith1EquatableProperty(int: 3),
      TypeWith1EquatableProperty(int: 1),
      TypeWith1EquatableProperty(int: 2)
    ].sorted(\.int)
    
    XCTAssertEqual(
      sortedArray,
      [ TypeWith1EquatableProperty(int: 1),
        TypeWith1EquatableProperty(int: 2),
        TypeWith1EquatableProperty(int: 3)
      ]
    )
  }
  
//MARK: uniqueElements
  func test_uniqueElements_Hashable() {
    XCTAssertEqual(
      [1, 1, 1].firstUniqueElements,
      [1]
    )

    XCTAssertEqual(
      "ABCDEFABCDEFEDCBA".firstUniqueElements,
      ["A", "B", "C", "D", "E", "F"]
    )
  }
	
	func test_uniqueElements_Equatable() {
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

private struct TypeWith1EquatableProperty: Equatable {
	let int: Int
}
