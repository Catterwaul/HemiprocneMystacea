import Combine

/// `ObservableObject`s  which all forward their `objectWillChange` through a parent.
@propertyWrapper public final class ObservableObjectCollection<Objects: Collection>: ObservableObject
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
public extension ObservableObjectCollection {
  func assignCancellable() {
    cancellable = wrappedValue.map(\.objectWillChange).merged.subscribe(objectWillChange)
  }
}
