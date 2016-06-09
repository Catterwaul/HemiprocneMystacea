extension NSNotificationCenter {
  /// Creates MultiClosure "events" based on `NSNotification`s
  ///
  ///- Parameter notificationName: An observer for this will be added.
  ///- Parameter Signal_init: creates a `Signal`
  ///  from an `NSNotification`'s `userInfo` dictionary
  static func 📡init
  <Signal>(
    notificationName notificationName: String,
    Signal_init: [NSObject: AnyObject] -> Signal
  ) -> MultiClosure<Signal> {
    let 📡 = MultiClosure<Signal>()
    NSNotificationCenter.defaultCenter().addObserverForName(
      notificationName,
      object: nil,
      queue: NSOperationQueue.mainQueue()
    ){notification in
      📡[Signal_init(notification.userInfo!)]
    }
    return 📡
  }
}