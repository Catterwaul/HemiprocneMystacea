import Foundation
import HM
import XCTest

final class IndexPathTestCase: XCTestCase {
  func test_makeProcess() {
    struct Doubles {
      subscript(indexPath: IndexPath) -> Int {
        indexPath.item * 2
      }
    }
    
    var double: Int = 0
    
    let process = IndexPath.makeProcess(
      processables: .init {
        [doubles = Doubles()]
        indexPath in doubles[indexPath]
      },
      process: { double = $0 }
    )
    
    process(IndexPath(item: 1, section: 0))
    XCTAssertEqual(double, 2)
    
    process(IndexPath(item: 234, section: 0))
    XCTAssertEqual(double, 468)
  }
}
