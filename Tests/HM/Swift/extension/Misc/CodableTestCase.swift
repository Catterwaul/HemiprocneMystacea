import XCTest

final class CodableTestCase: XCTestCase {
  func test_init_codingDictionary() {
    struct 🐈: Decodable {
      let mood: String
    }

    let mood = "😺"

    XCTAssertEqual(
      try 🐈(codingDictionary: ["mood": mood]).mood,
      mood
    )
  }
}
