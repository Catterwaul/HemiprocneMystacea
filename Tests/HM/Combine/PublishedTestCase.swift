import Combine
import HM
import XCTest

final class PublishedTestCase: XCTestCase {
  func test_Codable() {
    final class Type: ObservableObject, Codable {
      @Published var property = "🏚"
    }

    let instance = Type()

    XCTAssertEqual(
      instance.property,
      try JSONDecoder().decode(
        Type.self,
        from: try JSONEncoder().encode(instance)
      ).property
    )
  }
}
