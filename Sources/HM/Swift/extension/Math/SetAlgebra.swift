public extension SetAlgebra {
  var contains: Subscript<Self, Element, Bool> {
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
