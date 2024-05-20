public typealias Tuple2<Element> = (Element, Element)
public typealias Tuple3<Element> = (Element, Element, Element)
public typealias Tuple4<Element> = (Element, Element, Element, Element)

// MARK: - append

/// Create a new tuple with one more element.
@inlinable public func append<Element0, Element1, Element2>(
  _ elements: (Element0, Element1), _ element: Element2
) -> (Element0, Element1, Element2) {
  (elements.0, elements.1, element)
}

/// Create a new tuple with one more element.
@inlinable public func append<Element0, Element1, Element2, Element3>(
  _ elements: (Element0, Element1, Element2), _ element: Element3
) -> (Element0, Element1, Element2, Element3) {
  (elements.0, elements.1, elements.2, element)
}

// MARK: - map

/// Transform each tuple element.
@inlinable public func map<Element, Transformed>(
  _ elements: Tuple2<Element>,
  _ transform: (Element) throws -> Transformed
) rethrows -> Tuple2<Transformed> {
  try (transform(elements.0), transform(elements.1))
}

/// Transform each tuple element.
@inlinable public func map<Element, Transformed>(
  _ elements: Tuple3<Element>,
  _ transform: (Element) throws -> Transformed
) rethrows -> Tuple3<Transformed> {
  try append(
    map(prefix(elements), transform), 
    transform(elements.2)
  )
}

/// Transform each tuple element.
@inlinable public func map<Element, Transformed>(
  _ elements: Tuple4<Element>,
  _ transform: (Element) throws -> Transformed
) rethrows -> Tuple4<Transformed> {
  try append(
    map(prefix(elements), transform),
    transform(elements.3)
  )
}

// MARK: - prefix

/// The first 2 elements.
@inlinable public func prefix<Element0, Element1>(
  _ elements: (Element0, Element1, some Any)
) -> (Element0, Element1) {
  (elements.0, elements.1)
}

/// The first 3 elements.
@inlinable public func prefix<Element0, Element1, Element2>(
  _ elements: (Element0, Element1, Element2, some Any)
) -> (Element0, Element1, Element2) {
  (elements.0, elements.1, elements.2)
}

// MARK: -

/// Reverse the order of the elements in the tuple.
@inlinable public func reverse<Element0, Element1>(
  _ element0: Element0, _ element1: Element1
) -> (Element1, Element0) {
  (element1, element0)
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

public extension Sequence {
  typealias Tuple2 = HM.Tuple2<Element>
  typealias Tuple3 = HM.Tuple3<Element>
  typealias Tuple4 = HM.Tuple4<Element>

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
