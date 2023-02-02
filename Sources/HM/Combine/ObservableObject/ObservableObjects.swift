import Combine

@propertyWrapper
public final class ObservableObjects<Objects: Sequence>: ObservableObject
where
  Objects.Element: ObservableObject,
  Objects.Element.ObjectWillChangePublisher == ObservableObjectPublisher
{
  public init(wrappedValue: Objects) {
    self.wrappedValue = wrappedValue
    assignCancellable()
  }

  @Published public var wrappedValue: Objects {
    didSet { assignCancellable() }
  }

  private var cancellable: AnyCancellable!
}

// MARK: - public
public extension ObservableObjects {
  func assignCancellable() {
    cancellable = wrappedValue.map(\.objectWillChange).merged.subscribe(objectWillChange)
  }
}
