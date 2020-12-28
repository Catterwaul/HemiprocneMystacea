import HM
import XCTest

final class KeyPathsTestCase: XCTestCase {
  func test_subscript_partially_applied_get() {
    let oneTo5 = 1...5
    let keyPath = \(Int, Int).0
    XCTAssert(
      zip(oneTo5, oneTo5).map(keyPath[]).elementsEqual(oneTo5)
    )
  }
  
  func test_subscript_get() {
    let keyPath = \Double.isZero
    XCTAssertFalse(keyPath[1.0]())
  }

  func test_ReferenceWritableKeyPath_subscripts() {
    let mangoat = "👨🐐"

    class Class {
      var mango = "🥭"
    }

    let instance = Class()
    let makeProperty: (Class) -> Computed = (\Class.mango)[]
    let property = makeProperty(instance)
    property.wrappedValue = mangoat
    XCTAssertEqual(instance.mango, mangoat)
  }
} 
