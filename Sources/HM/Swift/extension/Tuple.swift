/// A workaround for not being able to extend tuples.
public struct Tuple<Elements> {
  public var elements: Elements

  public init(_ elements: Elements) {
    self.elements = elements
  }
}

public extension Tuple {
  // MARK: - 4-tuple
  /// Create a new tuple with one more element.
  static subscript<Element0, Element1, Element2, Element3, Element4>(
    tuple: Elements, element: Element4
  ) -> (Element0, Element1, Element2, Element3, Element4)
  where Elements == (Element0, Element1, Element2, Element3) {
    (tuple.0, tuple.1, tuple.2, tuple.3, element)
  }

  // MARK: - 5-tuple
  /// Create a new tuple with one more element.
  static subscript<Element0, Element1, Element2, Element3, Element4, Element5>(
    tuple: Elements, element: Element5
  ) -> (Element0, Element1, Element2, Element3, Element4, Element5)
  where Elements == (Element0, Element1, Element2, Element3, Element4) {
    (tuple.0, tuple.1, tuple.2, tuple.3, tuple.4, element)
  }
}
