import HM
import XCTest

final class UITableViewTestCase: XCTestCase {
	func test_makeCellsWithDependenciesInjected() {
		let tableView = UITableView()
		
		_ = tableView.makeCellsWithDependenciesInjected(
			getCellDependencies: {_ in}
		) as NamedGetOnlySubscript<IndexPath, Cell>
	}
	private final class Cell: UITableViewCell, injectDependencies {
		func inject(dependencies _: Void) {}
	}
}
