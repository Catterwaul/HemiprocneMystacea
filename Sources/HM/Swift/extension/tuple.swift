/// A workaround for not being able to extend tuples.
public struct Tuple<Elements> {
  public var elements: Elements

  public init(_ elements: Elements) {
    self.elements = elements
  }
}

public extension Tuple {
  /// Stuff an element into a 2-tuple that will have a labeled first element
  /// when converted to a return value.
  /// - Note: Useful because a single-element tuple can't have a label.
  init<LabeledElement>(_ labeledElement: LabeledElement)
  where Elements == (LabeledElement, Never?) {
    self.init( (labeledElement, nil) )
  }

  init<Parameters, Transformed0, Transformed1>(
    _ transform0: @escaping (Parameters) -> Transformed0,
    _ transform1: @escaping (Parameters) -> Transformed1
  )
  where Elements == (
    (Parameters) -> Transformed0,
    (Parameters) -> Transformed1
  ) {
    self.init( (transform0, transform1) )
  }

  func callAsFunction<Parameters, Transformed0, Transformed1>(
    _ parameters: Parameters
  ) -> (Transformed0, Transformed1)
  where Elements == (
    (Parameters) -> Transformed0,
    (Parameters) -> Transformed1
  ) {
    ( elements.0(parameters), elements.1(parameters) )
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
    self.init( (transform0, transform1, transform2) )
  }

  func callAsFunction<Parameters, Transformed0, Transformed1, Transformed2>(
    _ parameters: Parameters
  ) -> (Transformed0, Transformed1, Transformed2)
  where Elements == (
    (Parameters) -> Transformed0,
    (Parameters) -> Transformed1,
    (Parameters) -> Transformed2
  ) {
    ( elements.0(parameters), elements.1(parameters), elements.2(parameters) )
  }
}

public extension Sequence {
  var tuple2: (Element, Element)? { makeTuple2()?.tuple }
  var tuple3: (Element, Element, Element)? { makeTuple3()?.tuple }
  var tuple4: (Element, Element, Element, Element)? { makeTuple4()?.tuple }

  private func makeTuple2() -> (
    tuple: (Element, Element),
    getNext: () -> Element?
  )? {
    var iterator = makeIterator()
    let getNext = { iterator.next() }

    guard
      let _0 = getNext(),
      let _1 = getNext()
    else {
      return nil
    }

    return ( (_0, _1), getNext )
  }

  private func makeTuple3() -> (
    tuple: (Element, Element, Element),
    getNext: () -> Element?
  )? {
    guard
      let (tuple2, getNext) = makeTuple2(),
      let _2 = getNext()
    else {
      return nil
    }

    return ( (tuple2.0, tuple2.1, _2), getNext )
  }

  private func makeTuple4() -> (
    tuple: (Element, Element, Element, Element),
    getNext: () -> Element?
  )? {
    guard
      let (tuple3, getNext) = makeTuple3(),
      let _3 = getNext()
    else {
      return nil
    }

    return ( (tuple3.0, tuple3.1, tuple3.2, _3), getNext )
  }
}
