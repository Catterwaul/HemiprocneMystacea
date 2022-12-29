import Combine

public extension Publisher<Void, Never> {
  /// Forward output through an  `ObservableObject`'s `objectWillChange`.
  func forwardedThroughObjectWillChange<Object: ObservableObject>(of object: Object) -> AnyCancellable
  where Object.ObjectWillChangePublisher == ObservableObjectPublisher {
    sink { [unowned object] in object.objectWillChange.send() }
  }
}
