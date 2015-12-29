import UIKit

extension UIAlertController {
   typealias Action = (
      title: String,
      style: UIAlertActionStyle,
      ƒ: (() -> ())?
   )

	convenience init(
		title: String?,
		message: String?,
      style: UIAlertControllerStyle = .Alert,
		actions: [Action] = [(title: "OK", style: .Default, nil)]
	) {
		self.init(
         title: title,
         message: message,
         preferredStyle: style
      )
		for action in actions {addAction(UIAlertAction(
			title: action.title,
			style: action.style,
			handler: {
				guard let ƒ = action.ƒ else {return nil}
				return {_ in ƒ()}
			}()
		))}
	}
}