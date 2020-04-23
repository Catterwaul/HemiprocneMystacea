/// An error that represents casting gone wrong. 🧙‍♀️🙀
public enum CastError: Error {
  /// An undesired cast is possible.
  case possible

  /// An desired cast is not possible.
  case impossible
}

public extension CastError {
  /// `nil` if  an `Instance` can be cast to `Desired`. Otherwise, `.impossible`.
  init?<Instance, Desired>(_: Instance, desired _: Desired.Type) {
    self.init(Instance.self, desired: Desired.self)
  }

  /// `nil` if  a `Source` can be cast to `Desired`. Otherwise, `.impossible`.
  init?<Source, Desired>(_: Source.Type, desired _: Desired.Type) {
    if Source.self is Desired.Type
    { return nil }

    self = .impossible
  }

  /// `nil` if  an `Instance` cannot be cast to `Undesired`. Otherwise, `.possible`.
  init?<Instance, Undesired>(_: Instance, undesired _: Undesired.Type) {
    self.init(Instance.self, undesired: Undesired.self)
  }

  /// `nil` if  a `Source` cannot be cast to `Undesired`. Otherwise, `.possible`.
  init?<Source, Undesired>(_: Source.Type, undesired _: Undesired.Type) {
    guard Source.self is Undesired.Type
    else { return nil }

    self = .possible
  }
}
