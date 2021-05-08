import HM
import XCTest

final class RawRepresentableTestCase: XCTestCase {
	func test_contains() {
		enum Alien: String {
			case 👽
      case 👾
		}
			
		XCTAssert(Alien.contains("👽"))
		XCTAssert(Alien.contains("👾"))
		XCTAssertFalse(Alien.contains("🐗"))
		
		enum NumberOfCats: Int {
      case bad
      case good = 7_000_000
		}
		
		XCTAssert(NumberOfCats.contains(0))
		XCTAssert(NumberOfCats.contains(7_000_000))
		XCTAssertFalse(NumberOfCats.contains(-10))
		XCTAssertFalse(NumberOfCats.contains(45672475))
	}

  func test_InitializableWithElementSequence_init() {
    enum 🧶: String, CaseIterable { case 🧵, 🎻 }

    XCTAssertEqual(
      🧶.allCases,
      try .init(rawValues: ["🧵", "🎻"])
    )

    XCTAssertThrowsError(
      try Set<🧶>(rawValues: ["🪕"])
    )
  }
}
