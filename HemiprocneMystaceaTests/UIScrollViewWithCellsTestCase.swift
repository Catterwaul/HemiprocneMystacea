import HM
import XCTest
import UIKit

final class UIScrollViewWithCellsTestCase: XCTestCase {
  func test() {
    let collectionView = UICollectionView(
      frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()
    )
    XCTAssertNil(
      collectionView.getVisibleCell( indexPath: IndexPath( item: 0, section: 0) )
    )
  }
}
