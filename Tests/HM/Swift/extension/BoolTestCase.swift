import HM
import XCTest

final class BoolTestCase: XCTestCase {
  func test_Comparable() {
    XCTAssertGreaterThan(true.comparable, false)
  }

  func test_init_validBits() throws {
    let boolFromFalseBit = try XCTUnwrap(Bool(bit: 0))
    XCTAssertFalse(boolFromFalseBit)

    let boolFromTrueBit = try XCTUnwrap(Bool(bit: 1 as UInt8))
    XCTAssertTrue(boolFromTrueBit)
  }

  func test_init_invalidBits() {
    XCTAssertNil(Bool(bit: -1))
    XCTAssertNil(Bool(bit: 2 as Int32))
  }

  func test_init_binaryString() throws {
    XCTAssertFalse(
      try XCTUnwrap(Bool(binaryString: "0"))
    )
    XCTAssertTrue(
      try XCTUnwrap(Bool(binaryString: "1"))
    )
    
    XCTAssertNil(
      Bool(binaryString: "-1")
    )
    XCTAssertNil(
      Bool(binaryString: "2")
    )

    XCTAssertNil(
      Bool(binaryString: "🎱🧵")
    )
  }

  func test_reduce() {
    var isSnackTime = false

    XCTAssertEqual(
      isSnackTime.reduce("🐈", "🐹".appending),
      "🐈"
    )

    isSnackTime = true
    XCTAssertEqual(
      isSnackTime.reduce("🐈") { "🏃 \($0)" },
      "🏃 🐈"
    )
  }
  
// MARK: - Sequences of Bools
  func test_containsOnly() {
    let trueConditions = [
      { true },
      { 1 < 2 },
      { "🦁" == "🦁" }
    ]
    
    XCTAssert(trueConditions.containsOnly(true))
    XCTAssertFalse(
      (trueConditions + [ { false } ])
      .containsOnly(true)
    )
  }
}
