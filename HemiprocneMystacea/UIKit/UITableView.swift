import UIKit

public extension UITableView {
	public typealias NumberOfRows = Int
	public typealias RespondToSelected<Selected> = (Selected) -> Void
}
