public extension AnySequence {
  /// - Parameter getNext: Executed as the `next` method of this sequence's iterator.
  init(_ getNext: @escaping () -> Element?) {
    self.init( Iterator(getNext) )
  }
}
