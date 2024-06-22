import Combine

/// The simplest way to forward one `objectWillChange` through another
/// is to make `ObservableObjectPublisher` be a `Subject`,
/// so that `Publisher.subscribe` can be used with it.
extension ObservableObjectPublisher: @retroactive Subject {
  public func send(subscription: any Subscription) {
    subscription.request(.unlimited)
  }

  public func send(_: Void) {
    send()
  }

  public func send(completion _: Subscribers.Completion<Never>) { }
}
