public extension CollectionOfOne<Never?> {
  /// A collection whose element is irrelevant.
  init() {
    self.init(nil)
  }
}

extension CollectionOfOne: @retroactive ExpressibleByIntegerLiteral where Element: _ExpressibleByBuiltinIntegerLiteral {
  public init(integerLiteral element: Element) {
    self.init(element)
  }
}

extension CollectionOfOne: @retroactive ExpressibleByUnicodeScalarLiteral where Element: _ExpressibleByBuiltinUnicodeScalarLiteral {
  public init(unicodeScalarLiteral element: Element) {
    self.init(element)
  }
}

extension CollectionOfOne: @retroactive ExpressibleByExtendedGraphemeClusterLiteral where Element: _ExpressibleByBuiltinExtendedGraphemeClusterLiteral {
  public init(extendedGraphemeClusterLiteral cluster: Element) {
    self.init(cluster)
  }
}

extension CollectionOfOne: @retroactive ExpressibleByStringLiteral where Element: _ExpressibleByBuiltinStringLiteral {
  public init(stringLiteral element: Element) {
    self.init(element)
  }
}
