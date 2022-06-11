import protocol Foundation.ContiguousBytes

public extension ContiguousBytes {
  func load<T>(_: T.Type = T.self) -> T {
    withUnsafeBytes { $0.load(as: T.self) }
  }

  func load<Element>(_: [Element].Type = [Element].self) -> [Element] {
    withUnsafeBytes {
      $0.withMemoryRebound(to: Element.self, Array.init)
    }
  }
}
