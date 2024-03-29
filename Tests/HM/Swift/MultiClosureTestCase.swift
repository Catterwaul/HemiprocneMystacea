@testable import HM
import XCTest

final class MultiClosureTestCase: XCTestCase {
  func test_multiClosure() {
    var x = 0
    let closures: [EquatableClosure<()>] = [
      .init { _ in x += 1 },
      .init { _ in x += 2 }
    ]
    let multiClosure = MultiClosure(closures)
    multiClosure()
    XCTAssertEqual(x, 3)
    multiClosure -= closures.first!
    multiClosure()
    XCTAssertEqual(x, 5)
  }
   
  func test_setRemoval() {
    let closure: EquatableClosure<()>! = .init { _ in }
    let multiClosure = MultiClosure(closure)
    
    XCTAssertNotEqual(multiClosure.closures, [])
    XCTAssertNotEqual(closure.multiClosures, [])
    multiClosure -= closure
    XCTAssertEqual(multiClosure.closures, [])
    XCTAssertEqual(closure.multiClosures, [])
  }

  func test_deallocation() {
    var closure: EquatableClosure<()>! = .init { _ in }
    var multiClosure: MultiClosure! = .init(closure)

    XCTAssertNotEqual(multiClosure.closures, [])
    closure = nil
    XCTAssertEqual(multiClosure.closures, [])

    closure = EquatableClosure { _ in }
    multiClosure += closure
    XCTAssertNotEqual(closure.multiClosures, [])
    multiClosure = nil
    XCTAssertEqual(closure.multiClosures, [])
  }
}
