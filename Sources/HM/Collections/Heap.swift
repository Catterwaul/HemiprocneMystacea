import HeapModule

public extension Heap {
  /// A  non-`Comparable` "`Value`" type, which provides a `Comparable` value for use with a `Heap`.
  struct ElementValuePair<Value> {
    public var value: Value
    private let makeElement: (Value) -> Element
  }
}

public extension Heap.ElementValuePair {
  init(
    _ value: Value,
    _ makeElement: @escaping (Value) -> Element
  ) {
    self.init(value: value, makeElement: makeElement)
  }

  var element: Element { makeElement(value) }
}

extension Heap.ElementValuePair: Comparable {
  public static func < (lhs: Self, rhs: Self) -> Bool {
    lhs.element < rhs.element
  }

  /// Only necessary because Comparable: Equatable. 😞
  public static func == (lhs: Self, rhs: Self) -> Bool {
    fatalError()
  }
}
