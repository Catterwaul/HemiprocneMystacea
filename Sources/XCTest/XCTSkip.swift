import typealias XCTest.XCTSkip

public extension XCTSkip {
  /// Skip the rest of a test if an error is thrown.
  /// - Throws: `XCTSkip` if `getSuccess` throws an error.
  /// - Returns: A `Success`, otherwise.
  /// - Note: Similar to `XCTUnwrap`.
  static func uponFailure<Success>(
    of getSuccess: @autoclosure () throws -> Success
  ) throws -> Success {
    do { return try getSuccess() }
    catch { throw XCTSkip() }
  }
}
