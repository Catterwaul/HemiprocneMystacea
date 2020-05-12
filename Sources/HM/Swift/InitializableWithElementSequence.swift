/// A type that can be initialized with a `Sequence` of its `Element`s.
public protocol InitializableWithElementSequence: Sequence {
  init<Sequence: Swift.Sequence>(_: Sequence)
  where Sequence.Element == Element
}

extension Array: InitializableWithElementSequence { }
extension Set: InitializableWithElementSequence { }
