import HM
import XCTest

final class KeyPathsTestCase: XCTestCase {
  func test_asClosure() {
    let oneTo5 = 1...5
    let keyPath = \(Int, Int).0
    XCTAssert(
      zip(oneTo5, oneTo5).map(keyPath.asClosure).elementsEqual(oneTo5)
    )
  }

  func test_map() {
    XCTAssertEqual(
      [true, true].map(!\.self),
      [false, false]
    )
  }

  func test_ReferenceWritableKeyPath_subscripts() {
    class Class {
      var mango = "🥭"
    }

    let mangoat = "👨🐐"

    @Computed(root: Class(), keyPath: \.mango) var mango;
    mango = mangoat
    XCTAssertEqual(mango, mangoat)
  }
} 
