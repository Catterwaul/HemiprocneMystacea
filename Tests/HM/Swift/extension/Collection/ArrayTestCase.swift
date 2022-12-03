import HM
import XCTest

final class ArrayTestCase: XCTestCase {
  func test_init_tuple() {
    XCTAssertEqual(
      Array(mirrorChildValuesOf: (1, 2, 3, 4, 5)),
      [1, 2, 3, 4, 5]
    )

    XCTAssertNil(
      [Int](mirrorChildValuesOf: (1, 2, "3", 4, 5))
    )
  }

  func test_without() {
    let rabbitsAndEars = ["👯", "🐇", "🐰", "👂", "🌽"]

    XCTAssertNil(
      rabbitsAndEars.without(prefix: ["🐰"])
    )

    XCTAssertEqual(
      rabbitsAndEars.without(prefix: ["👯", "🐇"]),
      ["🐰", "👂", "🌽"]
    )
  }
}
