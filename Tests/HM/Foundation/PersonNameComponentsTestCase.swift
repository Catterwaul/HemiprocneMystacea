import Foundation
import HM
import XCTest

private final class PersonNameComponentsTestCase: XCTestCase {
  func test_Comparable() {
    let names = [
      "Aladdin",
      "Dr. Ally Cat",
      "Yur A cat, Esq.",
      "yur D Cat, Esq.",
      "DR. BenGERMAN DÜD",
      "Ernie",
      "Gert",
      "jay",
      "John Jay",
      "Madonna",
      "Donna madsen",
      "Mr. yuri Ruley, Jr."
    ].compactMap(PersonNameComponentsFormatter().personNameComponents)

    XCTAssertEqual(names.sorted(), names)
  }
}
