import Foundation
import HM
import XCTest

private final class PersonNameComponentsTestCase: XCTestCase {
  func test_Comparable() {
    let names = [
      "Aladdin",
      "Dr. Ally Cat",
      "Yur A Cat, Esq.",
      "Yur D Cat, Esq.",
      "Dr. Bengerman Düd",
      "Ernie",
      "Gert",
      "Jay",
      "John Jay",
      "Madonna",
      "Donna Madsen",
      "Mr. Yuri Ruley, Jr."
    ].compactMap(PersonNameComponentsFormatter().personNameComponents)

    XCTAssertEqual(names.sorted(), names)
  }
}
