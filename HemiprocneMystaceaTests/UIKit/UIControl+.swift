import UIKit

extension UIControl {struct Event📦 {
   init(
      controlEvent: UIControlEvents,
		selector: Selector
   ) {
      self.controlEvent = controlEvent
      self.selector = selector
   }
   
   ///- Returns: A new event if one doesn't exist already.
   private(set) subscript(control: UIControl) -> MultiClosure<()> {
      mutating get {
         func Event() -> MultiClosure<()> {
            control.addTarget(control,
               action: selector,
               forControlEvents: controlEvent
            )
            let multiClosure = MultiClosure<()>()
            self[control] = multiClosure
            return multiClosure
         }
         return events.first🔎{$0.0.reference == control}?.1
            ?? Event()
		}
      set {
         let referencer = UnownedReferencer(control)
         events[referencer] = newValue
      }
	}
   
   private var events: [UnownedReferencer<UIControl>: MultiClosure<()>] = [:]
   private let
      controlEvent: UIControlEvents,
      selector: Selector
}}