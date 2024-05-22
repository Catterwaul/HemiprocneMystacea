import Tuplé

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

public enum TupleError: Error {
  case incorrectElementCount(expected: Int, actual: Int)
}

public extension Sequence {
  typealias Tuple2 = Tuplé.Tuple2<Element>
  typealias Tuple3 = Tuplé.Tuple3<Element>
  typealias Tuple4 = Tuplé.Tuple4<Element>

  var tuple2: Tuple2 { get throws { try makeTuple2().tuple } }
  var tuple3: Tuple3 { get throws { try makeTuple3().tuple } }
  var tuple4: Tuple4 { get throws { try makeTuple4().tuple } }

  private func makeTuple2() throws -> (
    tuple: Tuple2,
    getNext: () -> Element?
  ) {
    var iterator = makeIterator()
    let getNext = { iterator.next() }

    guard let _0 = getNext()
    else { throw TupleError.incorrectElementCount(expected: 2, actual: 0) }
    guard let _1 = getNext()
    else { throw TupleError.incorrectElementCount(expected: 2, actual: 1) }

    return ((_0, _1), getNext)
  }

  private func makeTuple3() throws -> (
    tuple: Tuple3,
    getNext: () -> Element?
  ) {
    do {
      let (tuple, getNext) = try makeTuple2()
      
      guard let element = getNext()
      else { throw TupleError.incorrectElementCount(expected: 3, actual: 2) }
      
      return (append(tuple, element), getNext)
    } catch TupleError.incorrectElementCount(_, let actual) {
      throw TupleError.incorrectElementCount(expected: 3, actual: actual)
    }
  }

  private func makeTuple4() throws -> (
    tuple: Tuple4,
    getNext: () -> Element?
  ) {
    do {
      let (tuple, getNext) = try makeTuple3()

      guard let element = getNext()
      else { throw TupleError.incorrectElementCount(expected: 4, actual: 3) }

      return (append(tuple, element), getNext)
    } catch TupleError.incorrectElementCount(_, let actual) {
      throw TupleError.incorrectElementCount(expected: 4, actual: actual)
    }
  }
}
