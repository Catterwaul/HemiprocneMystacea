public extension KeyPath {
  /// Convert this `KeyPath` to a partially-applied get accessor.
  ///
  /// This is the same as what the compiler can do for key path expressions,
  /// but extends the capability to named variables.
  var asClosure: (Root) -> Value {
    { $0[keyPath: self] }
  }

  /// - Returns: A closure that returns a transformed `Value`.
  func map<Transformed>(
    _ transform: @escaping (Value) -> Transformed
  ) -> (Root) -> Transformed {
    { transform($0[keyPath: self]) }
  }
}

public extension KeyPath where Value == Bool {
  static prefix func !(keypath: KeyPath) -> (Root) -> Value {
    keypath.map(!)
  }
}

public extension Computed {
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
