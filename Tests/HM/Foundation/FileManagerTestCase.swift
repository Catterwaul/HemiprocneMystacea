import class Foundation.FileManager
import HM
import XCTest

final class FileManagerTestCase: XCTestCase {
  func test_userDocumentsDirectory() throws {
    XCTAssertEqual(
      FileManager.userDocumentsDirectory.lastPathComponent,
      "Documents"
    )
  }

  func test_removeExistingFile() throws {
    let url = FileManager.userDocumentsDirectory
      .appendingPathComponent("😺", isDirectory: true)

    var fileExists: Bool {
      FileManager.default.fileExists(atPath: url.path)
    }

    XCTAssertFalse(fileExists)

    try FileManager.default.createDirectory(
      at: url,
      withIntermediateDirectories: false
    )
    XCTAssert(fileExists)

    try FileManager.removeExistingFile(at: url)
    XCTAssertFalse(fileExists)
  }
}
