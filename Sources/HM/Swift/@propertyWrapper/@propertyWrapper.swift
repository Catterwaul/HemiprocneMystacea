public protocol wrappedValue<WrappedValue> {
  associatedtype WrappedValue
  var wrappedValue: WrappedValue { get }
}

public protocol wrappedValue_nonmutating_set: wrappedValue {
  var wrappedValue: WrappedValue { get nonmutating set }
}

public protocol projectedValue<ProjectedValue> {
  associatedtype ProjectedValue
  var projectedValue: ProjectedValue { get }
}

// MARK: - ReconstitutablePropertyWrapper

/// Makes a instance of a property wrapper usable with "wrapper syntax",
/// after having been passed as an instance.
public protocol ReconstitutablePropertyWrapper { }

public extension ReconstitutablePropertyWrapper {
  init(_ wrapper: Self) {
    self = wrapper
  }
}
