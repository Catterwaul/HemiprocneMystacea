public extension Sequence {
  /// A workaround for the language not supporting `as some Sequence<Element>`.
  var asSomeElementSequence: some Sequence<Element> { self }
}
