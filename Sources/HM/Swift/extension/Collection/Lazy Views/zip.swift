/// `zip` a sequence with a single value, instead of another sequence.
@inlinable public func zip<Sequence: Swift.Sequence, Constant>(
  _ sequence: Sequence, _ constant: Constant
) -> some Swift.Sequence<(Sequence.Element, Constant)> {
  zip(sequence, HM.sequence(constant))
}
