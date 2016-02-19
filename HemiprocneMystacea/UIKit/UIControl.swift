extension UIControl {
/// A subscriptable collection of MultiClosure "events" 
/// which abstracts the more complex Target-Action pattern.
struct Event📦 {
   /// Used once to set up an `Event📦` for a subclass of `UIControl`
   ///
   ///- Parameter controlEvent: `UIControlEvents` is an Option Set, 
   ///  so you can subscribe to multiple events if that ever makes sense.
   ///- Parameter selector: Extend your `UIControl` subclass to implement this, 
   ///  and call its correspoding event from that function.
   init(
      controlEvent: UIControlEvents,
		selector: Selector
   ) {
      self.controlEvent = controlEvent
      self.selector = selector
   }
   
   /// The method for retrieving the event for a `UIControl`,
   /// using itself as the key to a global event dictionary
   ///
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
         return events.first{$0.0.reference == control}?.1
            ?? Event()
		}
      set {
         let referencer = UnownedReferencer(control)
         events[referencer] = newValue
      }
	}
   
   //TODO: Reclaim the memory for UnownedReferencers that no longer reference.
   // It may be impossible without using weak referencing instead.
   private var events: [UnownedReferencer<UIControl>: MultiClosure<()>] = [:]
   
   // Stored for creation of new events
   private let
      controlEvent: UIControlEvents,
      selector: Selector
}}