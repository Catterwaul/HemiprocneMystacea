public extension CaseIterable where AllCases.Element: Equatable {
  /// Should be a static subscript. (See **Discussion**.)
  ///
  ///     CaseIterable[start...end]
  static func getRange(from start: Self, through end: Self) -> [AllCases.Element] {
    let indices = [start, end].compactMap(allCases.firstIndex)
    return Array(allCases[ indices[0]...indices[1] ])
  }
}
