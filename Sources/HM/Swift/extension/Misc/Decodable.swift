public extension Decodable {
  /// Initialize using 2 keyed, decoded arguments.
  /// - Parameters:
  ///   - init: An initializer (or  factory function) whose arguments are the decoded values.
  ///   - keys: `CodingKey` instances, matching the arguments.
  init<
    Parameter0: Decodable, Parameter1: Decodable, Key: CodingKey
  >(
    _ init: (Parameter0, Parameter1) -> Self,
    _ keys: (Key, Key),
    decoder: Decoder
  ) throws {
    let container = try decoder.container(keyedBy: Key.self)
    self = try `init`(
      container.decode(forKey: keys.0),
      container.decode(forKey: keys.1)
    )
  }
}
