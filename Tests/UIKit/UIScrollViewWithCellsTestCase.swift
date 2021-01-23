#if !os(macOS)
import XCTest
import HM
import UIKit_HM

final class UIScrollViewWithCellsTestCase: XCTestCase {
  func test() {
    let collectionView = UICollectionView(
      frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    XCTAssertThrowsError(
      try collectionView.visibleCell(at: IndexPath(item: 0, section: 0))
    ) { error in
      guard case UIScrollViewWithCellsExtensions.GetVisibleCellError.noVisisbleCell = error
      else { XCTFail(); return }
    }
  }
}
#endif
