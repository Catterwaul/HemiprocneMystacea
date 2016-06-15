extension NotificationCenter {
  /// Creates MultiClosure "events" based on `NSNotification`s
  ///
  ///- Parameter notificationName: An observer for this will be added.
  ///- Parameter Signal_init: creates a `Signal`
  ///  from an `NSNotification`'s `userInfo` dictionary
  static func 📡init
  <Signal>(
    notificationName: NSNotification.Name,
    Signal_init: ([NSObject: AnyObject]) -> Signal
  ) -> MultiClosure<Signal> {
    let 📡 = MultiClosure<Signal>()
    NotificationCenter.default().addObserver(
      forName: notificationName,
      object: nil,
      queue: OperationQueue.main()
    ){notification in
      📡[Signal_init((notification as NSNotification).userInfo!)]
    }
    return 📡
  }
}
