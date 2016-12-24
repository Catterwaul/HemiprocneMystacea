import UIKit

public extension UICollectionView {
	func makeCellsWithDependenciesInjected<Cell: UICollectionViewCell>(
		getCellDependencies: @escaping (IndexPath) -> Cell.Dependencies
	) -> NamedGetOnlySubscript<IndexPath, Cell>
	where Cell: injectDependencies {
		return NamedGetOnlySubscript{
			[unowned self] indexPath in
			
			let cell: Cell = self.getCell(indexPath: indexPath)
			cell.inject( dependencies: getCellDependencies(indexPath) )
			return cell
		}
	}
}
