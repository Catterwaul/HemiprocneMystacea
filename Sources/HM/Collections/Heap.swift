import HeapModule

public extension Heap {
  var sorted: some Sequence<Element> {
    sequence(state: self) { $0.popMin() }
  }
}
