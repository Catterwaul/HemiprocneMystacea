/// An error that represents that an undesired cast is possible.
public struct UndesiredCastError<Instance, UndesiredCast>: Error {
  /// `nil` if `instance` is not an `UndesiredCast`.
  /// - Parameter instance: Anything. 🤷
  /// - Returns: An `UndesiredCastError`
  /// - Note: Ineffective if `instance` is a protocol instance
  /// and `UndesiredCast` is `AnyObject`.
  public init?(_ instance: Instance, _: UndesiredCast.Type) {
    guard type(of: instance) is UndesiredCast.Type
    else { return nil }
  }
}
