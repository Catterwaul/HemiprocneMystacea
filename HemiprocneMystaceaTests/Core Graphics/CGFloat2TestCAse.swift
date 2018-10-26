import HM
import XCTest

final class CGFloat2TestCAse: XCTestCase {
  func test_add() {
    var sum =
      CGSize(width: 1, height: 2)
      + CGSize(width: 3, height: 4)

    XCTAssertEqual( sum, CGSize(width: 4, height: 6) )

    sum += CGSize(width: -3, height: -4)

    XCTAssertEqual( sum, CGSize(width: 1, height: 2) )
  }

  func test_subtract() {
    var difference =
      CGVector(dx: 1, dy: 2)
      - CGVector(dx: 3, dy: 4)

    XCTAssertEqual( difference, CGVector(dx: -2, dy: -2) )

    difference -= CGVector(dx: -3, dy: -4)

    XCTAssertEqual( difference, CGVector(dx: 1, dy: 2) )

    XCTAssertEqual(
      CGSize(width: 60, height: -80)
        - CGSize(width: 50, height: -100),
      CGSize(width: 10, height: 20)
    )
  }

  func test_multiply() {
    XCTAssertEqual(
      CGVector(dx: -2, dy: -3) * 7,
      CGVector(dx: -14, dy: -21)
    )
  }

	func test_divideByPoint() {
		XCTAssertEqual(
			CGPoint(x: 6, y: 10)
				/ CGPoint(x: 3, y: 8),
			CGPoint(x: 2, y: 1.25)
		)
	}
	
	func test_divideByFloat() {
		XCTAssertEqual(
			CGPoint(x: 6, y: 10) / 4,
			CGPoint(x: 1.5, y: 2.5)
		)
	}

  func test_initWithPoint() {
    XCTAssertEqual(
      CGSize( CGPoint(x: 5, y: 55) ),
      CGSize( width: 5, height: 55 )
    )
  }

  func test_clamped() {
    let point = CGPoint(x: -4, y: 20)
    XCTAssertEqual(
      point.clamped( within: CGRect(x: 1, y: 1, width: 10, height: 10) ),
      CGPoint(x: 1, y: 11)
    )
  }
}
