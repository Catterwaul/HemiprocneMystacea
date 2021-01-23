#if !os(macOS)
import HM
import UIKit

public extension UICollectionView {	
  /// Designed to make `cellForItemAt indexPath` a simple one-liner.
  ///- Returns: cellsWithDependenciesInjected
  final func makeCellsWithDependenciesInjected<Cell: UICollectionViewCell>(
    cellDependencies: NamedGetOnlySubscript<IndexPath, Cell.Dependencies>
  ) -> NamedGetOnlySubscript<IndexPath, Cell>
  where Cell: injectDependencies {
    reusableCells_makeCellsWithDependenciesInjected(
      cellDependencies: cellDependencies
    )
  }
}
#endif
