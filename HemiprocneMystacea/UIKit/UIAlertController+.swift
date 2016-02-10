public extension UIAlertController {typealias Action = (
   title: String,
   style: UIAlertActionStyle,
   ƒ: (() -> ())?
)}

public extension UIAlertController {
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
		self += actions
   }
}

public func += (controller: UIAlertController, action: UIAlertController.Action) {
   controller.addAction(UIAlertAction(
      title: action.title,
      style: action.style,
      handler: {
         guard let ƒ = action.ƒ else {return nil}
         return {_ in ƒ()}
      }()
   ))
}
public func += (controller: UIAlertController, actions: [UIAlertController.Action]) {
   for action in actions {controller += action}
}