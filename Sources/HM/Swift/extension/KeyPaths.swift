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
