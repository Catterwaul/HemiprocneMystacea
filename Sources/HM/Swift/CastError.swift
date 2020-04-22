public enum CastError {
    /// An error that represents that a desired cast is not possible.
  public struct Desired<Instance, DesiredCast>: Error {
    /// `nil` if `instance` is a `DesiredCast`.
    /// - Parameter instance: Anything. 🤷
    public init?(_ instance: Instance, _: DesiredCast.Type) {
      if instance is DesiredCast
      { return nil }
    }
  }

  /// An error that represents that an undesired cast is possible.
  public struct Undesired<Instance, UndesiredCast>: Error {
    /// `nil` if `instance` is not an `UndesiredCast`.
    /// - Parameter instance: Anything. 🤷
    /// - Note: Ineffective if `instance` is a protocol instance
    /// and `UndesiredCast` is `AnyObject`.
    public init?(_ instance: Instance, _: UndesiredCast.Type) {
      guard type(of: instance) is UndesiredCast.Type
      else { return nil }
    }
  }
}
