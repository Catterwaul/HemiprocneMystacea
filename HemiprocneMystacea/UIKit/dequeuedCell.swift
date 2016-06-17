//MARK: dequeuedCell
// This should be one function in one extension
// but it doesn't seem possible to express.
public extension dequeueReusableCell where Self: UICollectionView {
	///- Returns: A reusable cell dequeued without the standard need
	///  for passing its name as a `String`,
	///  and then casting to the desired type
	///
	///- Precondition: The name of `Cell` has been assigned to the `Identifier`
	///  for a cell that this Collection View uses
	final func dequeuedCell
	<Cell: UICollectionViewCell>
	(indexPath: IndexPath) -> Cell {
		return dequeueReusableCell_dequeuedCell(indexPath: indexPath)
	}
}
public extension dequeueReusableCell where Self: UITableView {
    ///- Returns: A reusable cell dequeued without the standard need
    ///  for passing its name as a `String`,
    ///  and then casting to the desired type
    ///
    ///- Precondition: The name of `Cell` has been assigned to the `Identifier`
    ///  for a cell that this Table View uses
    final func cell
    <Cell: UIView>
    () -> Cell {
        return dequeueReusableCell(
            withIdentifier: String(Cell)
        ) as! Cell
    }

	///- Returns: A reusable cell dequeued without the standard need
	///  for passing its name as a `String`,
	///  and then casting to the desired type
	///
	///- Precondition: The name of `Cell` has been assigned to the `Identifier`
	///  for a cell that this Table View uses
	final func cell
	<Cell: UITableViewCell>
	(indexPath: IndexPath) -> Cell {
		return dequeueReusableCellWithReuseIdentifier_cell(indexPath: indexPath)
	}
}
private extension dequeueReusableCell {
	final func dequeueReusableCell_dequeuedCell
	<Cell: UIView>
	(indexPath: IndexPath) -> Cell {
		return dequeueReusableCell(
			String(Cell),
			forIndexPath: indexPath
		) as! Cell
	}
}

//MARK:- dequeueReusableCellWithReuseIdentifier
public protocol dequeueReusableCell {
	associatedtype Cell: UIView
	
	///- Attention: Called dequeueReusableCellWithIdentifier in UITableView
	func dequeueReusableCell(
		withReuseIdentifier _: String,
		for _: IndexPath
	) -> Cell
}

extension UICollectionView: dequeueReusableCell {}

extension UITableView: dequeueReusableCell {
	public final func dequeueReusableCell(
		identifier: String,
		forIndexPath indexPath: IndexPath
	) -> UITableViewCell {
		return dequeueReusableCell(
			withIdentifier: identifier,
			for: indexPath
		)
	}
	
	public func dequeueReusableCell(
		withReuseIdentifier _: String,
		for: IndexPath
	) -> UITableViewCell {
		return dequeueReusableCell(withIdentifier: "", for: f)
	}
}
