import UIKit

//MARK: getCell
// This should be one function in one extension
// but it doesn't seem possible to express.
public extension dequeueReusableCell where Self: UICollectionView {
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
}

public extension dequeueReusableCell where Self: UITableView {
	///- Returns: A reusable cell
	///  dequeued without the standard need for passing its name as a `String`,
	///  and then casting to the desired type
	///
	///- Precondition: The name of `Cell` has been assigned to the `Identifier`
	///  for a cell that this Table View uses
	final func getCell<Cell: UITableViewCell>() -> Cell {
		return dequeueReusableCell(
			withIdentifier: String(describing: Cell.self)
		) as! Cell
	}

	///- Returns: A reusable cell
	///  dequeued without the standard need for passing its name as a `String`,
	///  and then casting to the desired type
	///
	///- Precondition: The name of `Cell` has been assigned to the `Identifier`
	///  for a cell that this Table View uses
	final func getCell<Cell: UITableViewCell>(
		indexPath: IndexPath
	) -> Cell {
		return dequeueReusableCell(indexPath: indexPath)
	}
}

//MARK: private
private extension dequeueReusableCell {
	final func dequeueReusableCell<Cell: UIView>(
		indexPath: IndexPath
	) -> Cell {
		return dequeueReusableCell(
			withReuseIdentifier: String(describing: Cell.self),
			for: indexPath
		) as! Cell
	}
}

//MARK:- dequeueReusableCell
public protocol dequeueReusableCell {
	associatedtype ReusableCell: UIView
	
	func dequeueReusableCell(
		withReuseIdentifier: String,
		for: IndexPath
	) -> ReusableCell
}

extension UICollectionView: dequeueReusableCell {}

extension UITableView: dequeueReusableCell {
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
