import Combine
import HM
import XCTest

final class PublishedObjectTestCase: XCTestCase {
  func test() {
    var parent: Optional = Parent()
    
    var value: Void? = nil
    weak var child: Optional = parent!.child
    let cancellable = parent!.objectWillChange.sink { value = $0 }
    _ = cancellable
    parent!.child.property = "🍷"
    XCTAssertNotNil(value)
    XCTAssertNotNil(child)
    parent!.child = .init()
    XCTAssertNil(child)
    value = nil
    parent!.child.property = "🍷"
    XCTAssertNotNil(value)

    // Test for retain cycles
    do {
      weak var weak = parent
      XCTAssertNotNil(weak)
      parent = nil
      XCTAssertNil(weak)
      XCTAssertNil(child)
    }
  }

  func test_Codable() {
    XCTAssertEqual(
      "🍇",
      try JSONDecoder().decode(
        Parent.self,
        from: try JSONEncoder().encode(Parent())
      ).child.property
    )
  }
}

fileprivate final class Parent: ObservableObject & Codable {
  final class Child: ObservableObject & Codable {
    @Published var property = "🍇"
  }

  @Published.Object var child = Child()
}
