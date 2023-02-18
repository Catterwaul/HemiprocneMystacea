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
