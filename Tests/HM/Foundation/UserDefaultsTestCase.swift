import HM
import XCTest

final class UserDefaultsTestCase: XCTestCase {
  func test() {
    let key = "🔑"

    UserDefaults[key] = true
    XCTAssert(UserDefaults[key] == true)

    UserDefaults[key] = 9
    XCTAssertEqual(UserDefaults[key], 9)
  }

  func test_Dictionary() {
    enum Day: Int, LosslessStringConvertible {
     case sunday = 1, monday
    }

    let key = "🔑"
    let dayta = [Day.sunday: "🌞", .monday: "🌛"]

    UserDefaults[key] = PropertyListDictionary(dayta)
    XCTAssertEqual(UserDefaults["🔑"], dayta)

    UserDefaults[key] = PropertyListDictionary([1: "🌞", 2: "🌛"])
    XCTAssertEqual(UserDefaults["🔑"], dayta)

    UserDefaults.standard[key] = ["1": "🌞", "2": "🌛"]
    XCTAssertEqual(UserDefaults["🔑"], dayta)
  }
}
