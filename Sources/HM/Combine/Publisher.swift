import Combine

public extension Sequence where Element: Publisher {
  var merged: Publishers.MergeMany<Element> { .init(self) }
}
