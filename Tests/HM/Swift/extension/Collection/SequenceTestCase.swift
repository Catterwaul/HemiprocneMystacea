import HM
import XCTest

final class SequenceTestCase: XCTestCase {
// MARK:- Operators

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

// MARK:- Properties

  func test_consecutivePairs() {
    XCTAssertTrue(
      Array([1, 3, 9, -44].consecutivePairs)
      ==
      [(1, 3), (3, 9), (9, -44)]
    )
  }

  func test_count() {
    XCTAssertEqual(
      stride(from: 0, to: 10, by: 2).count, 5
    )
  }

  func test_first() {
    let odds = stride(from: 1, through: 9, by: 2)

    XCTAssertEqual(odds.first, 1)
    XCTAssertNil(odds.prefix(0).first)
  }

  func test_pauseable() {
    range: do {
      let upperLimit = 5
      let pauseableRange = AnyIterator(pauseable: 1...upperLimit)

      _ = pauseableRange.next()
      for _ in pauseableRange.prefix(1) { }

      func doNothin<NothinDoin>(_: NothinDoin) { }
      pauseableRange.prefix(1).forEach(doNothin)
      _ = pauseableRange.prefix(1).map(doNothin)

      XCTAssertEqual(
        Array(pauseableRange), Array(5...upperLimit)
      )
    }

    typealias Number = Int
    let pauseableFibonacciSequence =
      AnyIterator( pauseable: FibonacciSequence<Number>() )

    func getNext(_ count: Int) -> [Number] {
      .init( pauseableFibonacciSequence.prefix(count) )
    }

    XCTAssertEqual(getNext(10), [0, 1, 1, 2, 3, 5, 8, 13, 21, 34])
    XCTAssertEqual(getNext(10), [55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181])
  }

  func test_removingDuplicates() {
    XCTAssertEqual(
      String("⛲️⛲️⛲️🥐🥐⛲️⛲️⛲️⛲️🥐🥐🥐".removingDuplicates),
      "⛲️🥐⛲️🥐"
    )
  }

//MARK:- Subscripts

  func test_subscript_maxArrayCount() {
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

// MARK:- Methods

  func test_containsOnly() {
    XCTAssert(["🐯", "🐯"].containsOnly("🐯"))
  }

  func test_getCount() throws {
    XCTAssertEqual(
      [1, 2, nil].count(where:) { $0 < 3 },
      2
    )
  }

  func test_getFirst() {
    let array: [Any] = [1, "🥇"]
    
    XCTAssertEqual(array.getFirst(), "🥇")

    let getFirstInt = { array.getFirst(Int.self) }
    XCTAssertEqual(getFirstInt(), 1)
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
      dictionary.max(by: \.value)!.key,
      "💯"
    )
    
    XCTAssertEqual(
      dictionary.min(by: \.value)!.key,
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

  func test_onlyMatch() {
    XCTAssertEqual( try (1...5).onlyMatch { $0 > 4 }, 5 )

    XCTAssertThrowsError( try (1...5).onlyMatch { $0 < 4 } ) { error in
      guard case OnlyMatchError.moreThanOneMatch = error
      else { XCTFail(); return }
    }

    XCTAssertThrowsError( try (1...5).onlyMatch { $0 < 1 } ) { error in
      guard case OnlyMatchError.noMatches = error
      else { XCTFail(); return }
    }
  }
	
  func test_sortedBy() {
    let sortedArray = [
      TypeWith1EquatableProperty(int: 3),
      TypeWith1EquatableProperty(int: 1),
      TypeWith1EquatableProperty(int: 2)
    ].sorted(by: \.int)
    
    XCTAssertEqual(
      sortedArray,
      [ TypeWith1EquatableProperty(int: 1),
        TypeWith1EquatableProperty(int: 2),
        TypeWith1EquatableProperty(int: 3)
      ]
    )
  }

  func test_splitAndIncludeSeparators() {
    XCTAssertEqual(
      "¿What is your name? My name is 🐱, and I am a cat!"
        .split(separator: " ")
        .flatMap { $0.split(includingSeparators: \.isPunctuation) }
        .map(Array.init)
        .map { String($0) },
      [ "¿", "What", "is", "your", "name", "?",
        "My", "name", "is", "🐱", ",", "and", "I", "am", "a", "cat", "!"
      ]
    )
  }
  
//MARK: firstUniqueElements
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
