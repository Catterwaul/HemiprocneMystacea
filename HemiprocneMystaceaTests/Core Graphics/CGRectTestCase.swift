import HemiprocneMystacea
import XCTest

final class CGRectTestCase: XCTestCase {
  func testMax() {
    XCTAssertEqual(
      CGRect(
        x: -100,
        y: -200,
        width: 200,
        height: 400
      ).max,
      CGPoint(
        x: 100,
        y: 200
      )
    )
  }
  
//MARK: initializers
  func testInitWithSize() {
    XCTAssertEqual(
      CGRect(
        x: 0,
        y: 0,
        size: CGSize(
          width: 4,
          height: 4
        )
      ),
      CGRect(
        x: 0,
        y: 0,
        width: 4,
        height: 4
      )
    )
  }
  
  func testCopyWithNewHeight() {
    let rect = CGRect(
      x: 1,
      y: 2,
      width: 3,
      height: 4
    )
    XCTAssertEqual(
      CGRect(
        rect,
        height: 5
      ),
      CGRect(
        x: 1,
        y: 2,
        width: 3,
        height: 5
      )
    )
  }
}