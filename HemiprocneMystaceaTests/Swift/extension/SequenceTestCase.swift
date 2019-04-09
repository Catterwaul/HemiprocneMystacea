import HM
import XCTest

final class SequenceTestCase: XCTestCase {
  func test_max_and_min() {
    let dictionary = [
      "1️⃣": 1,
      "🔟": 10,
      "💯": 100
    ]
    
    XCTAssertEqual(
      dictionary.max { $0.value }! .key,
      "💯"
    )
    
    XCTAssertEqual(
      dictionary.min { $0.value }! .key,
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
    ].sorted { $0.int }
    
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
      [1, 1, 1].uniqueElements,
      [1]
    )
  }
	
	func test_uniqueElements_Equatable() {
		let uniqueArray = [
			TypeWith1EquatableProperty(int: 1),
			TypeWith1EquatableProperty(int: 1)
		].uniqueElements
		XCTAssertEqual(
			uniqueArray,
			[TypeWith1EquatableProperty(int: 1)]
		)
	}
}

private struct TypeWith1EquatableProperty: Equatable {
	let int: Int
}
