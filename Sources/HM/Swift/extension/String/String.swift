public extension String {
  ///- Returns: `nil` if not prefixed with `prefix`.
  func without(prefix: String) -> Self? {
    without(adfix: prefix, hasAdfix: hasPrefix, drop: dropFirst)
      .map(Self.init)
  }

  ///- Returns: `nil` if not suffixed with `suffix`.
  func without(suffix: String) -> Self? {
    without(adfix: suffix, hasAdfix: hasSuffix, drop: dropLast)
      .map(Self.init)
  }
}

/// `string0`, with all occurrences of `string1` removed
public func - (string0: String, string1: String) -> String {
  string0.replacingOccurrences(of: string1, with: "")
}

/// `string`, with all occurrences of each of the `strings` removed
public func - <Strings: Sequence>(
  string: String,
  strings: Strings
) -> String
where Strings.Element == String {
  strings.reduce(string, -)
}
