import protocol Foundation.ContiguousBytes

public extension ContiguousBytes {
  func load<T>(_: T.Type = T.self) -> T {
    withUnsafeBytes { $0.load(as: T.self) }
  }

  @available(
    swift, deprecated: 5.7,
    message: "`$0.withMemoryRebound(to: Element.self, Array.init)`?"
  )
  func load<Element>(_: [Element].Type = [Element].self) -> [Element] {
    withUnsafeBytes { .init($0.bindMemory(to: Element.self)) }
  }
}
