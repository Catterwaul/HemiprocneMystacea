public extension SetAlgebra {
  /// - Throws: if `elements` contains any duplicates.
  init(unique elements: some Sequence<Element>) throws {
    self = try elements.reduce(into: .init()) {
      guard $0.insert($1).inserted
      else { throw Error() }
    }
  }

  var contains: ValueSubscript<Self, Element, Bool> {
    mutating get {
      .init(
        &self,
        get: Self.contains,
        set: { set, element, newValue in
          if newValue {
            set.insert(element)
          } else {
            set.remove(element)
          }
        }
      )
    }
  }
}

private struct Error: Swift.Error { }
