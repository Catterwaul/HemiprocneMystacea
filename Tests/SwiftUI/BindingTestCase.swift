import struct SwiftUI.Binding
import HM
import SwiftUI_HM
import XCTest

private final class BindingTestCase: XCTestCase {
  func test_init_accessors() {
    final class Model {
      var leaves = "🍃"
    }
    
    let model = Model()
    let fallenLeaves = "🍂"
    @Binding(model, keyPath: \.leaves) var leaves;
    leaves = fallenLeaves
    XCTAssertEqual(model.leaves, fallenLeaves)
  }
  
  func test_not() {
    final class Model {
      var bool = true
    }
    
    let model = Model()
    @Binding(model, keyPath: \.bool) var bool;
    @Binding(projectedValue: !$bool) var negatedBool;
    negatedBool = true
    XCTAssertFalse(model.bool)
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
