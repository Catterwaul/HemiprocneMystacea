/// A type whose `Hashable` conformance could be auto-synthesized,
/// but either the API provider forgot, or more likely,
/// the API is written in Objective-C, and hasn't been modernized.
public protocol HashableSynthesizable: Hashable { }

public extension HashableSynthesizable {
  static func == (hashable0: Self, hashable1: Self) -> Bool {
    zip(hashable0.hashables, hashable1.hashables).allSatisfy(==)
  }

  func hash(into hasher: inout Hasher) {
    hashables.forEach { hasher.combine($0) }
  }
}

private extension HashableSynthesizable {
  private var hashables: [AnyHashable] {
    Mirror(reflecting: self).children
      .compactMap { $0.value as? AnyHashable }
  }
}
