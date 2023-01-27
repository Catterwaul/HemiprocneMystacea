import Combine

public extension Published
where Value: ObservableObject, Value.ObjectWillChangePublisher == ObservableObjectPublisher {
  /// An `ObservableObject` that forwards its `objectWillChange` through a parent.
  @propertyWrapper struct Object {
    // MARK: propertyWrapper

    @available(*, unavailable, message: "The enclosing type is not an 'ObservableObject'.")
    public var wrappedValue: Value { get { fatalError() } set { } }

    public static subscript<Parent: ObservableObject>(
      _enclosingInstance parent: Parent,
      wrapped _: ReferenceWritableKeyPath<Parent, Value>,
      storage keyPath: ReferenceWritableKeyPath<Parent, Self>
    ) -> Value
    where Parent.ObjectWillChangePublisher == ObservableObjectPublisher {
      get {
        @Computed(root: parent, keyPath: keyPath) var `self`

        // It's `nil` until a parent can be provided.
        if self.objectWillChangeSubscriber == nil {
          self.setParent(parent)
        }

        return self._wrappedValue
      }
      set {
        @Computed(root: parent, keyPath: keyPath) var `self`
        self._wrappedValue = newValue
        self.setParent(parent)
        parent.objectWillChange.send()
      }
    }

    // MARK: private

    private var _wrappedValue: Value

    /// The subscriber which forwards  `_wrappedValue`'s `objectWillChange` through a "parent".
    private var objectWillChangeSubscriber: AnyCancellable!
  }
}

// MARK: - public
public extension Published.Object {
  init(wrappedValue: Value) {
    _wrappedValue = wrappedValue
  }
}

// MARK: - private
private extension Published.Object {
  private mutating func setParent<Parent: ObservableObject>(_ parent: Parent)
  where Parent.ObjectWillChangePublisher == ObservableObjectPublisher {
    objectWillChangeSubscriber = _wrappedValue.objectWillChange.sink(parent.objectWillChange)
  }
}

// MARK: - Codable
extension Published.Object: Encodable where Value: Encodable {
  public func encode(to encoder: Encoder) throws {
    try _wrappedValue.encode(to: encoder)
  }
}
//
extension Published.Object: Decodable where Value: Decodable {
  public init(from decoder: Decoder) throws {
    self.init(wrappedValue: try .init(from: decoder))
  }
}
