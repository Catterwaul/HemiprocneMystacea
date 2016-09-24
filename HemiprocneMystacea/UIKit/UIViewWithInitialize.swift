import UIKit

public protocol UIViewWithInitialize {}

public extension UIViewWithInitialize {
	static func initialize_respondToIndexPath<Item>(
		get_item: @escaping (IndexPath) -> Item,
		respondToItem: @escaping (Item) -> Void
	) -> (IndexPath) -> Void {
		return {
			indexPath in respondToItem(
				get_item(indexPath)
			)
		}
	}
}
