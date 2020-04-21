import HM
import XCTest

final class UserDefaultsTestCase: XCTestCase {
  func test_subscript() {
    let key = "🔑"

    UserDefaults[key] = true
    XCTAssert(UserDefaults[key] == true)

    UserDefaults[key] = 9
    XCTAssertEqual(UserDefaults[key], 9)
  }

  func test_Dictionary() {
    let key = "🔑"

    UserDefaults[key] = Day.ta
    XCTAssertEqual(UserDefaults["🔑"], Day.ta)

    UserDefaults[key] = PropertyListDictionary([1: "🌞", 2: "🌛"])
    XCTAssertEqual(UserDefaults["🔑"], Day.ta)

    UserDefaults.standard[key] = ["1": "🌞", "2": "🌛"]
    XCTAssertEqual(UserDefaults["🔑"], Day.ta)
  }

  func test_propertyWrapper() {
    struct Type {
      @UserDefaults.Value(key: "🗝") var dayta = Day.ta
    }

    var instance = Type()
    XCTAssertEqual(instance.dayta, Day.ta)
    instance.dayta = nil
    XCTAssertNil(instance.dayta)
  }
}

private enum Day: Int, LosslessStringConvertible {
  case sunday = 1, monday

  static let ta = [Day.sunday: "🌞", .monday: "🌛"]
}
