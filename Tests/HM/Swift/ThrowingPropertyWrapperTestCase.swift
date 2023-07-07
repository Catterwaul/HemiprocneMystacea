import HM
import XCTest

final class ThrowingPropertyWrapperTestCase: XCTestCase {
  func test_assignmentOperator() {
    do {
      var optional: String? = "🪕"
      var some = "🎻"
      
      optional =? some
      XCTAssertEqual(optional, some)
      
      optional = "🎸"
      some =? optional
      XCTAssertEqual(optional, some)
    }

    do {
      var result = Result { "🪕" }
      var success = "🎻"

      result =? .init { success }
      XCTAssertEqual(try result.wrappedValue, success)

      result = .init { "🎸" }
      success =? result
      XCTAssertEqual(try result.wrappedValue, success)
    }
  }

  func test_sequenceOperator() {
    do {
      let sequence = Result { stride(from: 1, through: 5, by: 2) }
      var mapped: [Int] = []
      for element in sequence…? {
        mapped.append(element)
      }
      XCTAssertEqual(mapped, [1, 3, 5])
    }

    do {
      let dictionary: [Never: Never]? = nil
      XCTAssert(dictionary…?.isEmpty)
      for (_, _) in dictionary…? { }
    }
  }
}
