public extension Int {
  var factorial: Int {
    return
      self <= 1
      ? 1
      : (2...self).reduce(1, *)
  }
}
