import class Foundation.FileManager
import HM
import XCTest

final class FileManagerTestCase: XCTestCase {
  func test_userDocumentsDirectory() throws {
    XCTAssertEqual(
      URL.documentsDirectory.lastPathComponent,
      "Documents"
    )
  }

  func test_removeExistingFile() throws {
    let url: URL
    let documentsDirectory = URL.documentsDirectory
    if #available(iOS 16, *) {
      url = documentsDirectory.appending(path: "😺")
    } else {
      url = documentsDirectory
        .appendingPathComponent("😺", isDirectory: true)
    }

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
