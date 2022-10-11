/// A type that can be initialized with a `Sequence` of its `Element`s.
public protocol InitializableWithElementSequence: Sequence {
  init(_: some Sequence<Element>)
}

extension Array: InitializableWithElementSequence { }
extension Set: InitializableWithElementSequence { }
