#if !(os(macOS) || os(watchOS))
import HM
import UIKit

public protocol UIScrollViewWithCells: UIScrollView {
  /// The type which all cells are, or inherit from.
  associatedtype BaseCell: UIView

  func dequeueReusableCell(
    withReuseIdentifier: String,
    for: IndexPath
  ) -> BaseCell

  func cellForItem(at: IndexPath) -> BaseCell?
}

extension UICollectionView: UIScrollViewWithCells { }
extension UITableView: UIScrollViewWithCells {
  ///- Attention: Different signature than UICollectionView.dequeueReusableCell
  public func dequeueReusableCell(
    withReuseIdentifier identifier: String,
    for indexPath: IndexPath
  ) -> UITableViewCell {
    dequeueReusableCell(
      withIdentifier: identifier,
      for: indexPath
    )
  }

  public func cellForItem(at indexPath: IndexPath) -> UITableViewCell? {
    cellForRow(at: indexPath)
  }
}

// MARK: public
public extension UIScrollViewWithCells {
  ///- Returns: A reusable cell
	///  dequeued without the standard need for passing its name as a `String`,
	///  and then casting to the desired type
	///
	///- Precondition: The name of `Cell` has been assigned to the `Identifier`
	///  for a cell that this View uses
  func dequeueReusableCell<Cell: UIView>(indexPath: IndexPath) -> Cell {
    dequeueReusableCell(
      withReuseIdentifier: "\(Cell.self)",
      for: indexPath
    ) as! Cell
  }

  ///- Throws: UIScrollViewWithCells_GetVisibleCellError
  ///
  ///- Precondition: The name of `Cell` has been assigned to the `Identifier`
  ///  for a cell that this View uses
  func visibleCell<Cell: UIView>(at indexPath: IndexPath) throws -> Cell {
    typealias Error = UIScrollViewWithCellsExtensions.GetVisibleCellError

    guard let baseCell = cellForItem(at: indexPath)
    else { throw Error.noVisisbleCell }

    return try (baseCell as? Cell).wrappedValue ?? Error.incorrectType.throw()
  }
}

/// A namespace for nested types within `UIScrollViewWithCells`.
public enum UIScrollViewWithCellsExtensions {
  public enum GetVisibleCellError: Error {
    case noVisisbleCell, incorrectType
  }
}

// MARK: internal
extension UIScrollViewWithCells {
  func reusableCells_makeCellsWithDependenciesInjected<Cell: UIView>(
    cellDependencies: NamedGetOnlySubscript<IndexPath, Cell.Dependencies>
  ) -> NamedGetOnlySubscript<IndexPath, Cell>
  where Cell: injectDependencies {
    .init { [unowned self] indexPath in
      let cell: Cell = self.dequeueReusableCell(indexPath: indexPath)
      cell.inject(dependencies: cellDependencies[indexPath])
      return cell
    }
  }
}
#endif
