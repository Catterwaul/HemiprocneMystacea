import HM
import XCTest

final class OptionalTestCase: XCTestCase {
  func test_compacted() {
    XCTAssertEqual(
      ["💿🗺"],
      ("💿🗺" as Optional).compacted()
    )

    XCTAssertEqual(
      Set(),
      Int?.none.compacted()
    )
  }

  func test_unwrap() {
    func iterate(_ array: Any?...) throws {
      try array.forEach { _ = try $0.wrappedValue }
    }

    XCTAssertNoThrow(try iterate())
    XCTAssertThrowsError(try iterate(nil)) {
      XCTAssert($0 is Any?.UnwrapError)
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
        throws: Any?.UnwrapError.self
      )
      assert(
        try s["property"],
        throws: Any??.UnwrapError.self
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
