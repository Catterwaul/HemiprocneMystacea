import Foundation

public extension FileManager {
  /// Removes the file or directory at the specified URL, if it exists.
  ///
  /// - Note: This is a convenience to only call `removeItem` if `fileExists`.
  /// `removeItem` traps otherwise.
  static func removeExistingFile(at url: URL) throws {
    if `default`.fileExists(atPath: url.path) {
      try `default`.removeItem(at: url)
    }
  }
}
