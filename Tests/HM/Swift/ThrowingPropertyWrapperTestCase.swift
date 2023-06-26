import HM
import XCTest

final class ThrowingPropertyWrapperTestCase: XCTestCase {
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
