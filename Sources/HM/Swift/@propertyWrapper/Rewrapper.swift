/// Makes an instance usable as a property wrapper.
@propertyWrapper public struct Rewrapper<Wrapper: PropertyWrapper> {
  public var wrappedValue: Wrapper.WrappedValue { wrapper.wrappedValue }
  public var projectedValue: Wrapper.ProjectedValue { wrapper.projectedValue }
  private let wrapper: Wrapper
}

public extension Rewrapper {
  init(_ wrapper: Wrapper) {
    self.wrapper = wrapper
  }
}

public protocol PropertyWrapper {
  associatedtype WrappedValue
  associatedtype ProjectedValue

  var wrappedValue: WrappedValue { get }
  var projectedValue: ProjectedValue { get }
}
