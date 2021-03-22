#if !os(macOS)
import XCTest

final class UIViewTestCase: XCTestCase {
  func test_getSubviews() {
    let view = UIView()
    XCTAssertEqual(view.subviews(), [])

    final class Subview: UIView { }

    view.addSubview(Subview())
    XCTAssertNotNil(view.subviews().firstOfType(Subview.self))
  }
}
#endif
