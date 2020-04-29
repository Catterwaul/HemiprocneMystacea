import XCTest
import UIKit_HM

final class UIScrollViewWithCellsTestCase: XCTestCase {
  func test() {
    let collectionView = UICollectionView(
      frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    XCTAssertThrowsError(
      try collectionView.visibleCell( at: IndexPath( item: 0, section: 0) )
    ) { error in
      guard case UIScrollViewWithCells_GetVisibleCellError.noVisisbleCell = error
      else { XCTFail(); return }
    }
  }
}
