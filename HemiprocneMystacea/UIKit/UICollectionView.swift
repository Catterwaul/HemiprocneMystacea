import UIKit

public extension UICollectionView {
	public typealias NumberOfItems = Int
	public typealias RespondToFocused<Focused> = (Focused) -> Void
	public typealias RespondToSelected<Selected> = (Selected) -> Void
}
