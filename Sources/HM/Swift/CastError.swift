public enum CastError {
  /// An error that represents  a desired cast is not possible.
  public struct Impossible: CastErrorProtocol {
    /// `nil` if  a `Source` can be cast to `Desired`.
    public init?<Source, Desired>(_: Source.Type, _: Desired.Type) {
      if Source.self is Desired.Type
      { return nil }
    }
  }

  /// An error that represents an undesired cast is possible.
  public struct Possible: CastErrorProtocol {
    /// `nil` if  a `Source` cannot be cast to `Undesired`.
    public init?<Source, Undesired>(_: Source.Type, _: Undesired.Type) {
      guard Source.self is Undesired.Type
      else { return nil }
    }
  }
}

public protocol CastErrorProtocol: Error {
  init?<Source, Cast>(_: Source.Type, _: Cast.Type)
}

public extension CastErrorProtocol {
  /// `nil` if  a `Source` and `Cast` respect your casting wishes, either `Possible` or `Impossible`.
  init?<Instance, Cast>(_: Instance, _: Cast.Type) {
    self.init(Instance.self, Cast.self)
  }
}
