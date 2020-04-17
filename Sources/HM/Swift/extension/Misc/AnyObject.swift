/// An error that only stores reference types.
public struct AnyObjectError<Object>: Error {
  /// `nil` if object is not an object! 😺
  /// - Parameter object: Anything. 🤷
  /// - Returns: An `AnyObjectError`
  /// whose `object` is the argument to this initializer.
  /// - Note: Ineffective if `object` is a protocol instance.
  public init?(_ object: Object) {
    guard type(of: object) is AnyClass
    else { return nil }

    self.object = object
  }

  /// Some `AnyObject`.
  public let object: Object
}
