import UIKit

public protocol reusableCells: class {
	associatedtype ReusableCell: UIView
	
	func dequeueReusableCell(
		withReuseIdentifier: String,
		for: IndexPath
	) -> ReusableCell
}

extension UICollectionView: reusableCells {}
extension UITableView: reusableCells {
	///- Attention: Different signature than UICollectionView.dequeueReusableCell
	public func dequeueReusableCell(
		withReuseIdentifier identifier: String,
		for indexPath: IndexPath
	) -> UITableViewCell {
		return dequeueReusableCell(
			withIdentifier: identifier,
			for: indexPath
		)
	}
}

//MARK: internal
extension reusableCells {
	final func dequeueReusableCell<Cell: UIView>(
		indexPath: IndexPath
	) -> Cell {
		return dequeueReusableCell(
			withReuseIdentifier: String(describing: Cell.self),
			for: indexPath
		) as! Cell
	}
	
	final func reusableCells_makeCellsWithDependenciesInjected<Cell: UIView>(
		getCellDependencies: @escaping (IndexPath) -> Cell.Dependencies
	) -> NamedGetOnlySubscript<IndexPath, Cell>
	where Cell: injectDependencies {
		return NamedGetOnlySubscript{
			[unowned self]
			indexPath in
			
			let cell: Cell = self.dequeueReusableCell(indexPath: indexPath)
			cell.inject( dependencies: getCellDependencies(indexPath) )
			return cell
		}
	}
}
