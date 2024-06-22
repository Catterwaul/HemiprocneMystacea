#if !(os(watchOS))
import HM
import XCTest

final class CABasicAnimationTestCase: XCTestCase {
  func test_init() {
    _ = CABasicAnimation(
      keyPath: "",
      values: CABasicAnimation.Values(
        from: 0,
        to: 2 * CGFloat.pi
      ),
      duration: 0
    )
  }
}
#endif
