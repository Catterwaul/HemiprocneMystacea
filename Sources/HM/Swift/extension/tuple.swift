public typealias TuplePlaceholder = Void

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
