/// A workaround for limitations of Swift's observed properties.
///
/// Limitations of Swift's property observers:
/// 1. They are not mutable.
/// 2. They cannot be referenced as closures.
@propertyWrapper public struct Observed<Value> {
  public typealias WillSet = (_ newValue: Value) -> Void
  public typealias DidSet = (
    _ oldValue: Value,
    _ value: inout Value
  ) -> Void

  public var willSet: WillSet
  public var didSet: DidSet

  public var wrappedValue: Value {
    willSet { willSet(newValue) }
    didSet { didSet(oldValue, &wrappedValue) }
  }

  public var projectedValue: Self {
    get { self }
    set { self = newValue }
  }
}

// MARK: - public
public extension Observed {
  init(
    wrappedValue: Value,
    willSet: @escaping WillSet = { _ in },
    didSet: @escaping DidSet = { _, _ in }
  ) {
    self.wrappedValue = wrappedValue
    self.willSet = willSet
    self.didSet = didSet
  }
}
