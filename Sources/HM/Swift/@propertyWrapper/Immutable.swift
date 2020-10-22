/// An affordance for accessing the properties of an object
/// without the ability to mutate them.
@dynamicMemberLookup
public struct Immutable<Object: AnyObject> {
  private let object: Object
}

// MARK: - public
public extension Immutable {
  init(_ object: Object) {
    self.object = object
  }

  subscript<Value>(dynamicMember keyPath: KeyPath<Object, Value>) -> Value {
    object[keyPath: keyPath]
  }
}
