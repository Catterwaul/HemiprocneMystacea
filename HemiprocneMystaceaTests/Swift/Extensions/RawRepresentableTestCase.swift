import HM
import XCTest

final class RawRepresentableTestCase: XCTestCase {
	func test_contains() {
		enum Alien: String {
			case 👽, 👾
		}
			
		XCTAssertTrue(
			Alien.contains("👽")
		)
		XCTAssertTrue(
			Alien.contains("👾")
		)
		XCTAssertFalse(
			Alien.contains("🐗")
		)
		
		enum NumberOfCats: Int {
			case
			bad = 0,
			good = 7_000_000_000_000
		}
		
		XCTAssertTrue(
			NumberOfCats.contains(0)
		)
		XCTAssertTrue(
			NumberOfCats.contains(7_000_000_000_000)
		)
		XCTAssertFalse(
			NumberOfCats.contains(-10)
		)
		XCTAssertFalse(
			NumberOfCats.contains(45672475878)
		)
	}
}
