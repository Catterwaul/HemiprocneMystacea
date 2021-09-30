/// A workaround for limitations of Swift's computed properties.
/// 
/// Limitations of Swift's computed property accessors:
/// 1. They are not mutable.
/// 2. They cannot be referenced as closures.
@propertyWrapper public struct Computed<Value> {
  public typealias Get = () -> Value
  public typealias Set = (Value) -> Void

  public init(
    get: @escaping Get,
    set: @escaping Set
  ) {
    self.get = get
    self.set = set
  }

  public var get: Get
  public var set: Set

  public var wrappedValue: Value {
    get { get() }
    nonmutating set { set(newValue) }
  }

  public var projectedValue: Self {
    get { self }
    set { self = newValue }
  }
}

// MARK: - public
public extension Computed {
  init(
    wrappedValue: Value,
    get: @escaping Get = {
      fatalError("`get` must be assigned before accessing `wrappedValue`.")
    },
    set: @escaping Set
  ) {
    self.init(get: get, set: set)
    self.wrappedValue = wrappedValue
  }
  
  /// Convert a `KeyPath` to a get/set accessor pair.
  init<Root>(
    root: Root,
    keyPath: ReferenceWritableKeyPath<Root, Value>
  ) {
    self.init(
      get: { root[keyPath: keyPath] },
      set: { root[keyPath: keyPath] = $0 }
    )
  }
}
