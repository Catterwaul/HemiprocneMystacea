#if !(os(macOS) || os(watchOS))
import HM
import UIKit

public extension UICollectionView {	
  /// Designed to make `cellForItemAt indexPath` a simple one-liner.
  ///- Returns: cellsWithDependenciesInjected
  final func makeCellsWithDependenciesInjected<Cell: UICollectionViewCell & injectDependencies>(
    cellDependencies: NamedGetOnlySubscript<IndexPath, Cell.Dependencies>
  ) -> NamedGetOnlySubscript<IndexPath, Cell> {
    reusableCells_makeCellsWithDependenciesInjected(
      cellDependencies: cellDependencies
    )
  }
}
#endif
