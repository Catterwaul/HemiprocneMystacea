public func `repeat`(count: Int) -> some Sequence<Void> {
  repeatElement((), count: count)
}
