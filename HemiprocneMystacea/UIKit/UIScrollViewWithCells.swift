import UIKit

public protocol UIScrollViewWithCells: UIScrollView {
	associatedtype ReusableCell: UIView
	
	func dequeueReusableCell(
		withReuseIdentifier: String,
		for: IndexPath
	) -> ReusableCell

  func cellForItem(at: IndexPath) -> ReusableCell?
}

extension UICollectionView: UIScrollViewWithCells { }
extension UITableView: UIScrollViewWithCells {
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

  public func cellForItem(at indexPath: IndexPath) -> UITableViewCell? {
    return cellForRow(at: indexPath)
  }
}

//MARK: public
public extension UIScrollViewWithCells {
  ///- Returns: A reusable cell
	///  dequeued without the standard need for passing its name as a `String`,
	///  and then casting to the desired type
	///
	///- Precondition: The name of `Cell` has been assigned to the `Identifier`
	///  for a cell that this View uses
  func dequeueReusableCell<Cell: UIView>(indexPath: IndexPath) -> Cell {
    return dequeueReusableCell(
      withReuseIdentifier: "\(Cell.self)",
      for: indexPath
    ) as! Cell
  }

  ///- Returns: A visible cell
  ///  without the standard need for passing its name as a `String`,
  ///  and then casting to the desired type
  ///
  ///- Precondition: The name of `Cell` has been assigned to the `Identifier`
  ///  for a cell that this View uses
  func getVisibleCell<Cell: UIView>(indexPath: IndexPath) -> Cell? {
    return cellForItem(at: indexPath) as? Cell
  }
}

//MARK: internal
extension UIScrollViewWithCells {
 func reusableCells_makeCellsWithDependenciesInjected<Cell: UIView>(
    cellDependencies: NamedGetOnlySubscript<IndexPath, Cell.Dependencies>
  ) -> NamedGetOnlySubscript<IndexPath, Cell>
  where Cell: injectDependencies {
    return NamedGetOnlySubscript { [unowned self] indexPath in
      let cell: Cell = self.dequeueReusableCell(indexPath: indexPath)
      cell.inject(dependencies: cellDependencies[indexPath])
      return cell
    }
  }
}
