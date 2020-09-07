public extension KeyPath {
  /// Convert a `KeyPath` to a partially-applied get accessor.
  subscript() -> (Root) -> Value {
    { $0[keyPath: self] }
  }

  /// Convert a `KeyPath` to a get accessor.
  subscript(root: Root) -> () -> Value {
    { root[keyPath: self] }
  }
}

public extension ReferenceWritableKeyPath {
  /// Convert a `KeyPath` to a partially-applied get/set accessor pair.
  subscript() -> (Root) -> Computed<Value> {
    { self[$0] }
  }

  /// Convert a `KeyPath` to a get/set accessor pair.
  subscript(root: Root) -> Computed<Value> {
    .init(
      get: self[root],
      set: { root[keyPath: self] = $0 }
    )
  }
}
