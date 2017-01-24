import UIKit

public extension UICollectionView {
	///- Returns: A reusable cell
	///  dequeued without the standard need for passing its name as a `String`,
	///  and then casting to the desired type
	///
	///- Precondition: The name of `Cell` has been assigned to the `Identifier`
	///  for a cell that this Collection View uses
	final func getCell<Cell: UICollectionViewCell>(
		indexPath: IndexPath
	) -> Cell {
		return dequeueReusableCell(indexPath: indexPath)
	}
	
	/// Designed to make `cellForItemAt indexPath` a simple one-liner.
	///- Returns: cellsWithDependenciesInjected
	final func makeCellsWithDependenciesInjected<Cell: UICollectionViewCell>(
		getCellDependencies: @escaping (IndexPath) -> Cell.Dependencies
	) -> NamedGetOnlySubscript<IndexPath, Cell>
	where Cell: injectDependencies {
		return reusableCells_makeCellsWithDependenciesInjected(
			getCellDependencies: getCellDependencies
		)
	}
}
