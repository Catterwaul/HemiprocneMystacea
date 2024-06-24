/// An error that represents casting gone wrong. 🧙‍♀️🙀
public enum CastError: Error {
  /// An undesired cast is possible.
  case possible

  /// An desired cast is not possible.
  case impossible
}

public extension CastError {
  /// `nil` if  an `Instance` can be cast to `Desired`. Otherwise, `.impossible`.
  init?<Instance, Desired>(_ instance: Instance, desired _: Desired.Type) {
    if instance is Desired { return nil }

    self = .impossible
  }

  /// `nil` if  a `Source` can be cast to `Desired`. Otherwise, `.impossible`.
  init?<Source, Desired>(_: Source.Type, desired _: Desired.Type) {
    if Source.self is Desired.Type { return nil }

    self = .impossible
  }

  /// `nil` if  an `Instance` cannot be cast to `Undesired`. Otherwise, `.possible`.
  init?<Instance, Undesired>(_ instance: Instance, undesired _: Undesired.Type) {
    guard instance is Undesired else { return nil }

    self = .possible
  }

  /// `nil` if  a `Source` cannot be cast to `Undesired`. Otherwise, `.possible`.
  init?<Source, Undesired>(_: Source.Type, undesired _: Undesired.Type) {
    guard Source.self is Undesired.Type else { return nil }

    self = .possible
  }
}

/// Like a throwing version of `as?`.
///
/// The return type can be inferred, which the various forms of `as` do not support.
/// - Throws: `.impossible`
public func cast<Cast>(_ value: some Any) throws(CastError) -> Cast {
  guard case let value as Cast = value else { throw .impossible }
  return value
}
