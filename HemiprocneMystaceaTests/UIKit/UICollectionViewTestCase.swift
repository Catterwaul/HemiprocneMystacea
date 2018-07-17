import HM
import XCTest

final class UICollectionViewTestCase: XCTestCase {
	func test_makeCellsWithDependenciesInjected() {
		let collectionView = UICollectionView(
			frame: CGRect(),
			collectionViewLayout: .init()
		)
		_ = collectionView.makeCellsWithDependenciesInjected(
			cellDependencies: NamedGetOnlySubscript { _ in }
		) as NamedGetOnlySubscript<IndexPath, Cell>
	}
	private final class Cell: UICollectionViewCell, injectDependencies {
		func inject(dependencies _: Void) { }
	}
}
