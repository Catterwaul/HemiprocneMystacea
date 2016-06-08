// This should be one function in one extension
// but it doesn't seem possible to express.

public extension dequeueReusableCellWithReuseIdentifier where Self: UICollectionView {
	///- Returns: A reusable cell dequeued without the standard need
	///  for passing its name as a `String`,
	///  and then casting to the desired type
	///
	///- Precondition: The name of `Cell` has been assigned to the `Identifier`
	///  for a cell that this Collection View uses
	final func cell
	<Cell: UICollectionViewCell>
	(indexPath indexPath: NSIndexPath) -> Cell {
		return dequeueReusableCellWithReuseIdentifier_cell(indexPath: indexPath)
	}
}
public extension dequeueReusableCellWithReuseIdentifier where Self: UITableView {
	///- Returns: A reusable cell dequeued without the standard need
	///  for passing its name as a `String`,
	///  and then casting to the desired type
	///
	///- Precondition: The name of `Cell` has been assigned to the `Identifier`
	///  for a cell that this Table View uses
	final func cell
	<Cell: UITableViewCell>
	(indexPath indexPath: NSIndexPath) -> Cell {
		return dequeueReusableCellWithReuseIdentifier_cell(indexPath: indexPath)
	}
}
private extension dequeueReusableCellWithReuseIdentifier {
	final func dequeueReusableCellWithReuseIdentifier_cell
	<Cell: UIView>
	(indexPath indexPath: NSIndexPath) -> Cell {
		return dequeueReusableCellWithReuseIdentifier(
			String(Cell),
			forIndexPath: indexPath
		) as! Cell
	}
}

//MARK: Conformance
public protocol dequeueReusableCellWithReuseIdentifier {
	associatedtype Cell: UIView

	///- Attention: Called dequeueReusableCellWithIdentifier in UITableView
	func dequeueReusableCellWithReuseIdentifier(
		identifier: String,
		forIndexPath indexPath: NSIndexPath
	) -> Cell
}

extension UICollectionView: dequeueReusableCellWithReuseIdentifier {}

extension UITableView: dequeueReusableCellWithReuseIdentifier {
	public final func dequeueReusableCellWithReuseIdentifier(
		identifier: String,
		forIndexPath indexPath: NSIndexPath
	) -> UITableViewCell {
		return dequeueReusableCellWithIdentifier(
			identifier,
			forIndexPath: indexPath
		)
	}
}