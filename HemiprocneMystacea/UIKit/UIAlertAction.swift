import UIKit

public extension UIAlertAction {
	static var `default`: UIAlertAction {return UIAlertAction(title: "OK")}
	
	convenience init(
		title: String? = nil,
		style: UIAlertActionStyle = .default,
		respondTo_selection: (() -> Void)? = nil
  ) {
		self.init(
			title: title,
			style: style,
			handler: respondTo_selection.map{
				respondTo_selection in {_ in respondTo_selection()}
			}
		)
	}
}
