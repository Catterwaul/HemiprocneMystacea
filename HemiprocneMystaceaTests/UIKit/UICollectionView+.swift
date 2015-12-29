import UIKit

public extension UICollectionView {
	public func dequeuedCell<Cell: UICollectionViewCell>(forPath indexPath: NSIndexPath) -> Cell {
		return dequeueReusableCellWithReuseIdentifier(Cell.className,
         forIndexPath: indexPath
      ) as! Cell
	}
}