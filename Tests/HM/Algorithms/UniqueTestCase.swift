import HM
import XCTest

final class UniqueTestCase: XCTestCase {
  func test_uniquingWith() {
    XCTAssertEqual(
      [("🥴", 1), ("🥴", 2), ("😵‍💫", 2), ("😵‍💫", 1)]
        .map(KeyValuePair.init)
        .uniqued(on: \.key) { [$0, $1].max(by: \.value)! },
      [("🥴", 2), ("😵‍💫", 2)].map(KeyValuePair.init)
    )
  }
}
