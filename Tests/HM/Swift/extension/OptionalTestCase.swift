import HM
import XCTest

final class OptionalTestCase: XCTestCase {
  func test_assignmentOperator() {
    var optional: String? = "🪕"
    var some = "🎻"

    optional =? some
    XCTAssertEqual(optional, some)

    optional = "🎸"
    some =? optional
    XCTAssertEqual(optional, some)
  }

  func test_init_optionals() throws {
    var jenies: (String?, String?) = ("👖", "🧞‍♂️")

    do {
      let jenies: (String, String) = try XCTUnwrap(.init(jenies))
      XCTAssert(jenies == ("👖", "🧞‍♂️"))
    }

    jenies.1 = nil
    XCTAssertNil((String, String)?(jenies))
  }

  func test_map() {
    XCTAssertEqual(
      ["💿🗺"],
      ("💿🗺" as Optional).compacted()
    )

    XCTAssertEqual(
      Set(),
      Int?.none.compacted()
    )
  }

  func test_reduce() {
    var int: Int? = nil
    XCTAssertEqual(int.reduce(1, +), 1)

    int = 2
    XCTAssertEqual(int.reduce(1, +), 3)


    var optionalArray: [Int]? = nil
    let array: [Int] = [1, 2]

    XCTAssertEqual(
      optionalArray.reduce(array) { $1 + $0 },
      array
    )

    optionalArray = [0]
    XCTAssertEqual(
      optionalArray.reduce(array) { $1 + $0 },
      [0, 1, 2]
    )
  }

  func test_unwrap() {
    func iterate(_ array: Any?...) throws {
      try array.forEach { _ = try $0.wrappedValue }
    }

    XCTAssertNoThrow(try iterate())
    XCTAssertThrowsError(try iterate(nil)) {
      XCTAssert($0 is Optional<Any>.UnwrapError)
    }
  }

  func test_doubleWrapped() {
    do {
      struct S {
        var property: Int? = nil

        subscript(key: String) -> Any {
          get throws {
            try (
              Mirror(reflecting: self).children
                .first { $0.label == key }?
                .value
            )
            .doublyUnwrapped
          }
        }
      }

      var s = S()
      assert(
        try s[""],
        throws: Optional<Any>.UnwrapError.self
      )
      assert(
        try s["property"],
        throws: Optional<Any?>.UnwrapError.self
      )
      s.property = 0
      XCTAssertEqual(try s["property"] as! Int, 0)
    }

    do {
      struct S {
        var property: Int? = nil
        subscript(key: String) -> Any? {
          ( Mirror(reflecting: self).children
            .first { $0.label == key }?
            .value
          ).flatMap(_?.init)
        }
      }

      var s = S()
      XCTAssertNil(s[""])
      XCTAssertNil(s["property"])
      s.property = 0
      XCTAssertEqual(s["property"] as! Int, 0)
    }

    XCTAssertEqual(Any?(flattening: 0) as? Int, 0)
    XCTAssertEqual(Any?(flattening: Optional(0) as Any) as? Int, 0)
  }
}
