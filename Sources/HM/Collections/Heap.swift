import HeapModule

public extension Heap {
  /// A "`Value`" that uses an accompanying `Heap.Element` for sorting  via a `Heap`.
  /// - Note: If `Value` itself is `Comparable`, it can of course be inserted into a Heap directly.
  ///   This type is explicitly for cases where a different sorting rule is desired.
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
