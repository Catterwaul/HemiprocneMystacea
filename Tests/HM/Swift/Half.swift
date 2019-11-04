import HM
import XCTest

final class HalfTestCase: XCTestCase {
  func test_size() {
    XCTAssertEqual(MemoryLayout<Half>.size, 2)
  }
  
  func test_exponent() {
    XCTAssertEqual(9.7.exponent, (9.7 as Half).exponent)
  }
  
  func test_Equatable() {
    XCTAssertEqual(0 as Half, 0 as Half)
    XCTAssertNotEqual(1 as Half, 2 as Half)
  }
  
  func test_Comparable() {
    XCTAssertLessThan(-20 as Half, 30 as Half)
    XCTAssertGreaterThan(1000 as Half, 8 as Half)
  }
  
  func test_Conversion() {
    XCTAssertEqual(Float(8 as Half), 8)
    XCTAssertEqual(Double(777 as Half), 777)
    XCTAssertEqual(Float(-555.0 as Half), -555)
  }
}
