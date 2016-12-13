import UIKit

public protocol UIViewWithInitialize {}

public extension UIViewWithInitialize {
	static func makeRespondToIndexPath<Item>(
		getItem: @escaping (IndexPath) -> Item,
		respondToItem: @escaping (Item) -> Void
	) -> (IndexPath) -> Void {
		return {
			indexPath in respondToItem(
				getItem(indexPath)
			)
		}
	}
}
