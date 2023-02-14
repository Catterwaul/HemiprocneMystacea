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
      get { Self[_enclosingInstance: parent, storage: keyPath] }
      set { Self[_enclosingInstance: parent, storage: keyPath] = newValue }
    }

    // MARK: PublishedObject
    public var value: Value

    /// The subscription which forwards  `_wrappedValue`'s `objectWillChange` through a "parent".
    public var objectWillChangeSubscription: AnyCancellable!
  }
}

// MARK: - PublishedObject
extension Published.Object: PublishedObject {
  public var object: Value { value }
}

// MARK: - public
public extension Published.Object {
  init(wrappedValue: Value) {
    value = wrappedValue
  }
}

// MARK: - Codable
extension Published.Object: Encodable where Value: Encodable { }
extension Published.Object: Decodable where Value: Decodable { }
