import UIKit

public extension UICollectionView {
	func initializeGetCellWithDependenciesInjected<Cell: UICollectionViewCell>(
		getCellDependencies: @escaping (IndexPath) -> Cell.Dependencies
	) -> (IndexPath) -> Cell
	where Cell: injectDependencies {
		return {
			[unowned self] indexPath in
			
			let cell: Cell = self.getCell(indexPath: indexPath)
			
			cell.inject(
				dependencies: getCellDependencies(indexPath)
			)
			
			return cell
		}
	}
}
