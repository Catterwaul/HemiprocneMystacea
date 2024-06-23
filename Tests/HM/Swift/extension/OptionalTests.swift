import HM
import Testing

struct OptionalTests {
  @Test func test_doubleWrapped() throws {
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
      #expect(throws: Any?.Nil.self) { try s[""] }
      #expect(throws: Any??.Nil.self) { try s["property"] }
      s.property = 0
      #expect(try s["property"] as! Int == 0)
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
      #expect(s[""] == nil)
      #expect(s["property"] == nil)
      s.property = 0
      #expect(s["property"] as! Int == 0)
    }

    #expect(Any?(flattening: 0) as? Int == 0)
    #expect(Any?(flattening: Optional(0) as Any) as? Int == 0)
  }
}
