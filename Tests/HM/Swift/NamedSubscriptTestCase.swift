import HM
import XCTest

final class NamedSubscriptTestCase: XCTestCase {
  func test_NamedGetOnlySubscript() {
    let bodies = NamedGetOnlySubscript { (head: String) in
      [ "🐯": "🐅",
        "🐷": "🐖",
        "🐮": "🐄",
        "🐔": "🐓",
        "🐰": "🐇"
      ][head]!
    }
    
    XCTAssertEqual(bodies["🐯"], "🐅")
    XCTAssertEqual(bodies["🐷"], "🐖")
    XCTAssertEqual(bodies["🐮"], "🐄")
    XCTAssertEqual(bodies["🐔"], "🐓")
    XCTAssertEqual(bodies["🐰"], "🐇")
  }
  
  func test_multipleIndices() {
    enum Fruit: String {
      case apple = "🍏"
      case banana = "🍌"
      case strawberry = "🍓"
    }
    
    let rawFruits = NamedGetOnlySubscript { (fruit: Fruit) in
      fruit.rawValue
    }
    
    XCTAssertEqual(
      rawFruits[.banana, .apple],
      ["🍌", "🍏"]
    )
    
    let strawberryAppleAndBanana: [Fruit] = [
      .strawberry,
      .apple,
      .banana
    ]
    XCTAssertEqual(
      rawFruits[strawberryAppleAndBanana],
      ["🍓", "🍏", "🍌"]
    )
  }

  func test_ObjectSubscript() {
    final class Class {
      var bools: ObjectSubscript<Class, String, Bool?> {
        .init(
          self,
          get: { object in
            { object._bools[$0]
              ?? Bool(binaryString: $0)
            }
          },
          set: { $0._bools[$1] = $2 }
        )
      }

      private var _bools: [String: Bool] = [:]
    }

    let object = Class()
    let ghoul = "🧟"
    XCTAssertEqual(object.bools["1"], true)

    XCTAssertNil(object.bools[ghoul])
    object.bools[ghoul] = false
    XCTAssertEqual(object.bools[ghoul], false)
  }
}
