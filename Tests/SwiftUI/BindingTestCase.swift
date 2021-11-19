import struct SwiftUI.Binding
import HM
import XCTest

private final class BindingTestCase: XCTestCase {
  func test_init_accessors() {
    final class Model {
      var leaves = "🍃"
    }
    
    let model = Model()
    let fallenLeaves = "🍂"
    Binding(accessors: (\Model.leaves).accessors(model))
      .wrappedValue = fallenLeaves
    XCTAssertEqual(model.leaves, fallenLeaves)
  }
  
  func test_subscript_default() {
    var gummies: [String: String] = [:]
    Binding(
      get: { gummies },
      set: { gummies = $0}
    )["🪱", default: "🧸"].wrappedValue += "🍔"
    XCTAssertEqual(gummies["🪱"], "🧸🍔")
  }
}
