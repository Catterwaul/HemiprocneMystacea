import UIKit

public extension UICollectionView {
	public typealias NumberOfItems = Int
	public typealias RespondToFocused<Focused> = (Focused) -> Void
	public typealias RespondToSelected<Selected> = (Selected) -> Void
}

public extension UICollectionView {
	func initialize_get_cellWithDependenciesInjected<
		Cell: UICollectionViewCell
	>(
		get_cellDependencies: @escaping (IndexPath) -> Cell.Dependencies
	) -> (IndexPath) -> Cell
	where Cell: injectDependencies {
		return {
			[unowned self] indexPath in
			
			let cell: Cell = self.get_cell(indexPath: indexPath)
			
			cell.inject(
				dependencies: get_cellDependencies(indexPath)
			)
			
			return cell
		}
	}
}
