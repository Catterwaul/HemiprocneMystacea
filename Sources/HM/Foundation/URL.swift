import Foundation

@available(macOS, obsoleted: 13.15)
@available(iOS, obsoleted: 16)
@available(tvOS, obsoleted: 16)
@available(watchOS, obsoleted: 9)
public extension URL {
  /// The document directory for the current user.
  /// - Throws: `FileManager.Error.
  static var documentsDirectory: URL {
    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  }
}
