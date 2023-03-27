import XCTest

public extension XCTestCase {
  /// Assert that a specific type of error is thrown.
  func assert<Error: Swift.Error>(
    _ expression: @autoclosure () throws -> some Any,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line,
    throws: Error.Type
  ) {
    XCTAssertThrowsError(
      try expression(),
      message(),
      file: file,
      line: line
    ) { error in
      XCTAssert(error is Error)
    }
  }
}
