import Combine

public protocol PublishedObject {
  associatedtype Object: ObservableObject
  where Object.ObjectWillChangePublisher == ObservableObjectPublisher

  associatedtype WrappedValue

  init(wrappedValue: WrappedValue)
  var value: WrappedValue { get set }
  var object: Object { get }
  var objectWillChangeSubscription: AnyCancellable! { get set }
}

extension PublishedObject {
  static subscript<Parent: ObservableObject>(
    _enclosingInstance parent: Parent,
    storage keyPath: ReferenceWritableKeyPath<Parent, Self>
  ) -> WrappedValue
  where Parent.ObjectWillChangePublisher == ObservableObjectPublisher {
    get {
      @GetNonmutatingSet(root: parent, keyPath: keyPath) var `self`

      // It's `nil` until a parent can be provided.
      if self.objectWillChangeSubscription == nil {
        self.setParent(parent)
      }

      return self.value
    }
    set {
      @GetNonmutatingSet(root: parent, keyPath: keyPath) var `self`
      self.value = newValue
      self.setParent(parent)
      parent.objectWillChange.send()
    }
  }

  private mutating func setParent<Parent: ObservableObject>(_ parent: Parent)
  where Parent.ObjectWillChangePublisher == ObservableObjectPublisher {
    objectWillChangeSubscription = object.objectWillChange.subscribe(parent.objectWillChange)
  }
}

// MARK: - Codable
extension PublishedObject where WrappedValue: Encodable {
  public func encode(to encoder: Encoder) throws {
    try value.encode(to: encoder)
  }
}

extension PublishedObject where WrappedValue: Decodable {
  public init(from decoder: Decoder) throws {
    self.init(wrappedValue: try .init(from: decoder))
  }
}
