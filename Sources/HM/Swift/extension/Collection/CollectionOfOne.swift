public extension CollectionOfOne where Element == Never? {
  /// A collection whose element is irrelevant.
  init() {
    self.init(nil)
  }
}
