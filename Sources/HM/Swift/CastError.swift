/// An error that represents an impossible casting attempt. 🧙‍♀️🙀
public struct CastError: Error { }

/// Like a throwing version of `as?`.
///
/// The return type can be inferred, which the various forms of `as` do not support.
public func cast<Cast>(_ value: some Any) throws(CastError) -> Cast {
  guard case let value as Cast = value else { throw .init() }
  return value
}
