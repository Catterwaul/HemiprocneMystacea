import UIKit

public extension UITableView {
	public func dequeuedCell<Cell: UITableViewCell>(forPath indexPath: NSIndexPath) -> Cell {
		return dequeueReusableCellWithIdentifier(Cell.className,
         forIndexPath: indexPath
      ) as! Cell
	}
}