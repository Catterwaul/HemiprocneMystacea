import HM
import XCTest

final class BoolTestCase: XCTestCase {
  func test_initWithBinaryString() {
    XCTAssertFalse(
      Bool(binaryString: "0")!
    )
    XCTAssertTrue(
      Bool(binaryString: "1")!
    )
    
    XCTAssertNil(
      Bool(binaryString: "-1")
    )
    XCTAssertNil(
      Bool(binaryString: "2")
    )
  }
  
//MARK:- Sequences of Bools
  func test_containsOnly() {
    let trueConditions = [
      {true},
      {1 < 2},
      {"🦁" == "🦁"}
    ]
    
    XCTAssertTrue( trueConditions.containsOnly(true) )
    XCTAssertFalse(
      (trueConditions + [{false}])
      .containsOnly(true)
    )
  }
}
