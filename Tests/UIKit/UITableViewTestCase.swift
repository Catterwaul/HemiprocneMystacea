#if !(os(macOS) || os(watchOS))
import HM
import XCTest

final class UITableViewTestCase: XCTestCase {
  func test_makeCellsWithDependenciesInjected() {
    let tableView = UITableView()
    
    _ = tableView.makeCellsWithDependenciesInjected(
      cellDependencies: .init { _ in }
    ) as NamedGetOnlySubscript<IndexPath, Cell>
  }
  
  private final class Cell: UITableViewCell, injectDependencies {
    func inject(dependencies _: Void) { }
  }
}
#endif
