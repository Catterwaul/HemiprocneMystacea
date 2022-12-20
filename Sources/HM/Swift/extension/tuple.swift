/// Reverse the order of the elements in the tuple.
@inlinable public func reverse<T0, T1>(_ t0: T0, _ t1: T1) -> (T1, T0) {
  (t1, t0)
}

public func firstNonNil<Element>(_ tuple: (Element?, Element?)) -> Element? {
  switch tuple {
  case (let _0?, _):
    return _0
  case (nil, let _1?):
    return _1
  case (nil, nil):
    return nil
  }
}

/// Remove the labels from a tuple.
/// - Parameter tuple: A tuple that may have at least one label.
@inlinable public func removeLabels<T0, T1>(_ tuple: (T0, T1)) -> (T0, T1) {
  tuple
}

// MARK: -

/// A workaround for not being able to extend tuples.
public struct Tuple<Elements> {
  public var elements: Elements

  public init(_ elements: Elements) {
    self.elements = elements
  }
}

public extension Tuple {
  // MARK: - 2-tuple

  /// Create a new tuple with one more element.
  static subscript<Element0, Element1, Element2>(
    tuple: Elements, element: Element2
  ) -> (Element0, Element1, Element2)
  where Elements == (Element0, Element1) {
    (tuple.0, tuple.1, element)
  }

  /// Stuff an element into a 2-tuple that will have a labeled first element
  /// when converted to a return value.
  /// - Note: Useful because a single-element tuple can't have a label.
  init<LabeledElement>(_ labeledElement: LabeledElement)
  where Elements == (LabeledElement, Never?) {
    self.init((labeledElement, nil))
  }

  init<Parameters, Transformed0, Transformed1>(
    _ transform0: @escaping (Parameters) -> Transformed0,
    _ transform1: @escaping (Parameters) -> Transformed1
  )
  where Elements == (
    (Parameters) -> Transformed0,
    (Parameters) -> Transformed1
  ) {
    self.init((transform0, transform1))
  }

  func callAsFunction<Parameters, Transformed0, Transformed1>(
    _ parameters: Parameters
  ) -> (Transformed0, Transformed1)
  where Elements == (
    (Parameters) -> Transformed0,
    (Parameters) -> Transformed1
  ) {
    (elements.0(parameters), elements.1(parameters))
  }

  // MARK: - 3-tuple

  /// Create a new tuple with one more element.
  static subscript<Element0, Element1, Element2, Element3>(
    tuple: Elements, element: Element3
  ) -> (Element0, Element1, Element2, Element3)
  where Elements == (Element0, Element1, Element2) {
    (tuple.0, tuple.1, tuple.2, element)
  }

  init<Parameters, Transformed0, Transformed1, Transformed2>(
    _ transform0: @escaping (Parameters) -> Transformed0,
    _ transform1: @escaping (Parameters) -> Transformed1,
    _ transform2: @escaping (Parameters) -> Transformed2
  )
  where Elements == (
    (Parameters) -> Transformed0,
    (Parameters) -> Transformed1,
    (Parameters) -> Transformed2
  ) {
    self.init((transform0, transform1, transform2))
  }

  func callAsFunction<Parameters, Transformed0, Transformed1, Transformed2>(
    _ parameters: Parameters
  ) -> (Transformed0, Transformed1, Transformed2)
  where Elements == (
    (Parameters) -> Transformed0,
    (Parameters) -> Transformed1,
    (Parameters) -> Transformed2
  ) {
    (elements.0(parameters), elements.1(parameters), elements.2(parameters))
  }
}

public extension Sequence {
  typealias Tuple2 = (Element, Element)
  typealias Tuple3 = (Element, Element, Element)
  typealias Tuple4 = (Element, Element, Element, Element)

  var tuple2: Tuple2? { makeTuple2()?.tuple }
  var tuple3: Tuple3? { makeTuple3()?.tuple }
  var tuple4: Tuple4? { makeTuple4()?.tuple }

  private func makeTuple2() -> (
    tuple: Tuple2,
    getNext: () -> Element?
  )? {
    var iterator = makeIterator()
    let getNext = { iterator.next() }

    guard
      let _0 = getNext(),
      let _1 = getNext()
    else { return nil }

    return ((_0, _1), getNext)
  }

  private func makeTuple3() -> (
    tuple: Tuple3,
    getNext: () -> Element?
  )? {
    guard
      let (tuple, getNext) = makeTuple2(),
      let element = getNext()
    else { return nil }

    return (Tuple[tuple, element], getNext)
  }

  private func makeTuple4() -> (
    tuple: Tuple4,
    getNext: () -> Element?
  )? {
    guard
      let (tuple, getNext) = makeTuple3(),
      let element = getNext()
    else { return nil }

    return (Tuple[tuple, element], getNext)
  }
}
