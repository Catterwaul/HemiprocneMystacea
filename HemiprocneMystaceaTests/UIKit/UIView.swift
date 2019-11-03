import HM
import XCTest

final class UIViewTestCase: XCTestCase {
  func test_getSubviews() {
    let view = UIView()
    XCTAssertEqual(view.getSubviews(), [])

    final class Subview: UIView { }

    view.addSubview( Subview() )
    XCTAssertNotNil(view.getSubview() as? Subview)
  }
}
