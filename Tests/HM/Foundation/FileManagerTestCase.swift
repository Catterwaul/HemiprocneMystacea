#if !(os(watchOS))
import typealias Foundation.FileManager
import HM
import XCTest

final class FileManagerTestCase: XCTestCase {
  func test_removeExistingFile() throws {
    let url = URL.documentsDirectory.appending(path: "😺")

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
#endif
