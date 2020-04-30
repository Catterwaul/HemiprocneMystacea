import HM
import XCTest

final class UnkeyedDecodingContainerTestCase: XCTestCase {
  func test_Array_init() throws {
    struct 🧲: Decodable {
      let 🎤: String

      struct 🤡: Decodable {
        enum CodingKey: Swift.CodingKey { case 🧲 }

        init(from decoder: Decoder) throws {
          magnets = try .init(container:
            decoder.container(keyedBy: CodingKey.self)
            .nestedUnkeyedContainer(forKey: .🧲)
          ) { try $0.decode(🧲.self) }
        }
        
        let magnets: [🧲]
      }
    }

    XCTAssertEqual(
      try JSONDecoder().decode(
        🧲.🤡.self,
        from: """
          { "🧲": [
              { "🎤": "How" },
              { "🎤": "do" },
              { "🎤": "they" },
              { "🎤": "work?" }
            ]
          }
          """.data(using: .utf8)!
      ).magnets.map(\.🎤),
      ["How", "do", "they", "work?"]
    )
  }
}
