public extension IteratorProtocol {
  subscript(index: Int) -> Element {
    var iterator = self
    var element: Element!
    (0...index).forEach { _ in element = iterator.next() }
    return element
  }
}
