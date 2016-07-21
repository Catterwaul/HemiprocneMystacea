import UIKit

//MARK: get_cell
// This should be one function in one extension
// but it doesn't seem possible to express.
public extension dequeueReusableCell where Self: UICollectionView {
	///- Returns: A reusable cell 
	///  dequeued without the standard need for passing its name as a `String`,
	///  and then casting to the desired type
	///
	///- Precondition: The name of `Cell` has been assigned to the `Identifier`
	///  for a cell that this Collection View uses
	final func get_cell
	<Cell: UICollectionViewCell>
	(indexPath: IndexPath) -> Cell {
		return dequeueReusableCell_get_cell(indexPath: indexPath)
	}
}
public extension dequeueReusableCell where Self: UITableView {
    ///- Returns: A reusable cell 
	 ///  dequeued without the standard need for passing its name as a `String`,
    ///  and then casting to the desired type
    ///
    ///- Precondition: The name of `Cell` has been assigned to the `Identifier`
    ///  for a cell that this Table View uses
    final func get_cell
    <Cell: UITableViewCell>
	 () -> Cell {
        return dequeueReusableCell(
            withIdentifier: String(Cell.self)
        ) as! Cell
    }

	///- Returns: A reusable cell 
	///  dequeued without the standard need for passing its name as a `String`,
	///  and then casting to the desired type
	///
	///- Precondition: The name of `Cell` has been assigned to the `Identifier`
	///  for a cell that this Table View uses
	final func get_cell
	<Cell: UITableViewCell>
	(indexPath: IndexPath) -> Cell {
		return dequeueReusableCell_get_cell(indexPath: indexPath)
	}
}
private extension dequeueReusableCell {
	final func dequeueReusableCell_get_cell
	<Cell: UIView>
	(indexPath: IndexPath) -> Cell {
		return dequeueReusableCell(
			withReuseIdentifier: String(Cell.self),
			for: indexPath
		) as! Cell
	}
}

//MARK:- dequeueReusableCell
public protocol dequeueReusableCell {
	associatedtype Cell: UIView
	
	///- Attention: Called dequeueReusableCellWithIdentifier in UITableView
	func dequeueReusableCell(
		withReuseIdentifier: String,
		for: IndexPath
	) -> Cell
}

extension UICollectionView: dequeueReusableCell {}

extension UITableView: dequeueReusableCell {
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
