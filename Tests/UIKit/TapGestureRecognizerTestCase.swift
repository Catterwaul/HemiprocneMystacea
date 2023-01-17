#if !(os(macOS) || os(watchOS))
import typealias UIKit_HM.TapGestureRecognizer
import XCTest

final class TapGestureRecognizerTestCase {
  func test() {
    let recognizer = TapGestureRecognizer { }
    recognizer.perform()
    let _ = recognizer.perform.selector
  }
}
#endif
