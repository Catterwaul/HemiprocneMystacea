import HM
import XCTest
import UIKit

final class UIViewControllerTestCase: XCTestCase {
  func test_instantiate() {
    final class ViewController: UIViewController { }
    
//    _ = ViewController.instantiate()
//    let viewController: ViewController? = .instantiate()
  }

  func test_getChildren() {
    let parent = UIViewController()
    XCTAssertEqual(parent.getChildren(), [])

    final class Child: UIViewController { }

    parent.addChild( Child() )
    XCTAssertNotNil(parent.getChild() as? Child)
  }
}
