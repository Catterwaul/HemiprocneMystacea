import UIKit

public extension UICollectionView {	
	/// Designed to make `cellForItemAt indexPath` a simple one-liner.
	///- Returns: cellsWithDependenciesInjected
	final func makeCellsWithDependenciesInjected<Cell: UICollectionViewCell>(
		cellDependencies: NamedGetOnlySubscript<IndexPath, Cell.Dependencies>
	) -> NamedGetOnlySubscript<IndexPath, Cell>
	where Cell: injectDependencies {
		return reusableCells_makeCellsWithDependenciesInjected(
			cellDependencies: cellDependencies
		)
	}
}
