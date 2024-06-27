import HM
import XCTest

final class CGRectTestCase: XCTestCase {
// MARK: - Initializers

	func test_initWithSize() {
		XCTAssertEqual(
			CGRect(
				x: 0, y: 0,
				size: CGSize(width: 4, height: 4)
			),
			CGRect(
				x: 0, y: 0,
				width: 4, height: 4
			)
		)
	}

// MARK: - Properties
  func test_center() {
    XCTAssertEqual(
      CGRect(
        x: -100, y: -200,
        width: 200, height: 400
      ).center,
      .zero
    )
  }

  func test_max() {
    XCTAssertEqual(
      CGRect(
        x: -100, y: -200,
        width: 200, height: 400
      ).max,
      CGPoint(x: 100, y: 200)
    )
  }

  @available(iOS 18, macOS 15, tvOS 18, visionOS 2, watchOS 11, *)
  func test_points() {
    XCTAssertEqual(
      CGRect(x: 0, y: 0, width: 1, height: 1).points,
      [ [0, 1], [1, 1],
        [0, 0], [1, 0],
      ]
    )
  }

  func test_getSignedDistance() {
    XCTAssertEqual(
      SIMD2(1, 0).signedDistance(
        to: CGRect(x: -1, y: 0, width: 1, height: 1)
      ),
      1
    )

    XCTAssertEqual(
      SIMD2(1, 1).signedDistance(to: .init()),
      2.squareRoot()
    )
  }
}
