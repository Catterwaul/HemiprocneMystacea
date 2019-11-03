import HM
import XCTest
import UIKit

final class UIScrollViewWithCellsTestCase: XCTestCase {
  func test() {
    let collectionView = UICollectionView(
      frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    XCTAssertThrowsError(
      try collectionView.getVisibleCell( indexPath: IndexPath( item: 0, section: 0) )
    ) { error in
      switch error {
      case UIScrollViewWithCells_GetVisibleCellError.noVisisbleCell:
        break
      default:
        XCTFail()
      }
    }
  }
}
