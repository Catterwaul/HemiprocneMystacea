import HM
import XCTest

final class SequenceTestCase: XCTestCase {
  func test_tupleEquality() {
    let intStringTuples = [(1, "a"), (2, "b")]
    XCTAssertTrue(intStringTuples == intStringTuples.lazy)
    XCTAssertFalse(intStringTuples == [ intStringTuples[0] ].lazy)

    let boolDoubleTuples = [(true, 1.2), (false, 3.4)]
    XCTAssert(boolDoubleTuples == boolDoubleTuples)

    let threeTuples = intStringTuples.map { ($0.0, false, $0.1) }
    XCTAssertTrue(threeTuples == threeTuples.lazy)
    XCTAssertFalse(threeTuples == [].lazy)
  }
  
  func test_subscript_maxSubSequenceCount() {
    XCTAssertEqual(
      Array(
        (1...6)[maxArrayCount: 2]
      ),
      [ [1, 2], [3, 4], [5, 6] ]
    )

    XCTAssertEqual(
      Array(
        stride(from: 1, through: 3, by: 0.5)[maxArrayCount: 2]
      ),
      [ [1, 1.5], [2, 2.5], [3] ]
    )

    XCTAssertEqual(
      Array(
        (1...2)[maxArrayCount: 10]
      ),
      [ [1, 2] ]
    )
  }

  func test_containsOnly() {
    XCTAssert(["🐯", "🐯"].containsOnly("🐯"))
  }

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

// MARK:- Functions

  func test_getCount() throws {
    XCTAssertEqual(
      [1, 2, nil].getCount { $0 < 3 },
      2
    )
  }

  func test_getFirst() {
    XCTAssertEqual([1, "🥇"].getFirst(), "🥇")
  }

  func test_interleaved() {
    let oddsTo7 = stride(from: 1, to: 7, by: 2)
    let evensThrough10 = stride(from: 2, through: 10, by: 2)
    let oneThrough6 = Array(1...6)

    XCTAssertEqual(
      Array( oddsTo7.interleaved(with: evensThrough10) ),
      oneThrough6
    )

    XCTAssertEqual(
      Array(
        oddsTo7.interleaved(with: evensThrough10, keepingLongerSuffix: true)
      ),
      oneThrough6 + [8, 10]
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
