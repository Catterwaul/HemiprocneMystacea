import Combine

extension ObservableObjectPublisher: Subject {
  public func send(subscription: any Subscription) {
    subscription.request(.unlimited)
  }

  public func send(_: Void) {
    send()
  }

  public func send(completion _: Subscribers.Completion<Never>) { }
}
