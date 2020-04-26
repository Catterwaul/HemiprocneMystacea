import HM
import XCTest

final class KeyedDecodingContainerProtocolTestCase: XCTestCase {
  func test_decode() throws {
    let coatable = Coatable(🥼: 0, 🧥: "🧥")
    XCTAssertEqual(
      coatable,
      try JSONDecoder().decode(
        Coatable.self,
        from: try JSONEncoder().encode(coatable)
      )
    )
  }
}

private struct Coatable: Codable, Equatable {
  let 🥼: Int
  let 🧥: String
}

extension Coatable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    🥼 = try container.decode(forKey: .🥼)

    let 🧥: String = try container.decode(forKey: .🧥)
    self.🧥 = 🧥
  }
}
