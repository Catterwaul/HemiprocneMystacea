import HM
import UIKit

public extension UITableView {
  /// Designed to make `cellForRowAt indexPath` a simple one-liner.
  ///- Returns: cellsWithDependenciesInjected
  final func makeCellsWithDependenciesInjected<Cell: UITableViewCell>(
    cellDependencies: NamedGetOnlySubscript<IndexPath, Cell.Dependencies>
  ) -> NamedGetOnlySubscript<IndexPath, Cell>
  where Cell: injectDependencies {
    reusableCells_makeCellsWithDependenciesInjected(
      cellDependencies: cellDependencies
    )
  }
}
