import Combine

public extension Published.Object {
  @propertyWrapper struct Collection<Objects> where Value == ObservableObjectCollection<Objects> {
    // MARK: propertyWrapper
    @available(*, unavailable, message: "The enclosing type is not an 'ObservableObject'.")
    public var wrappedValue: Objects { get { fatalError() } set { } }

    public static subscript<Parent: ObservableObject>(
      _enclosingInstance parent: Parent,
      wrapped _: ReferenceWritableKeyPath<Parent, Objects>,
      storage keyPath: ReferenceWritableKeyPath<Parent, Self>
    ) -> Objects
    where Parent.ObjectWillChangePublisher == ObservableObjectPublisher {
      get { Self[_enclosingInstance: parent, storage: keyPath] }
      set { Self[_enclosingInstance: parent, storage: keyPath] = newValue }
    }

    // MARK: PublishedObject
    public var object: Value

    /// The subscription which forwards  `_wrappedValue`'s `objectWillChange` through a "parent".
    public var objectWillChangeSubscription: AnyCancellable!
  }
}

// MARK: - public
public extension Published.Object.Collection {
  init(wrappedValue: Objects) {
    object = .init(wrappedValue: wrappedValue)
  }
}


// MARK: - PublishedObject
extension Published.Object.Collection: PublishedObject {
  public var value: Objects {
    get { object.wrappedValue }
    set { object.wrappedValue = newValue }
  }
}

// MARK: - Codable
extension Published.Object.Collection: Codable where Objects: Codable { }
