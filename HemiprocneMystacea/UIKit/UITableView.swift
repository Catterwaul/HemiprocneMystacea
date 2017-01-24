import UIKit

public extension UITableView {
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
	
	/// Designed to make `cellForRowAt indexPath` a simple one-liner.
	///- Returns: cellsWithDependenciesInjected
	final func makeCellsWithDependenciesInjected<Cell: UITableViewCell>(
		getCellDependencies: @escaping (IndexPath) -> Cell.Dependencies
	) -> NamedGetOnlySubscript<IndexPath, Cell>
	where Cell: injectDependencies {
		return reusableCells_makeCellsWithDependenciesInjected(
			getCellDependencies: getCellDependencies
		)
	}
}
