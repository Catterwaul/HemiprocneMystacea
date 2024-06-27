import Foundation

public extension NotificationCenter {
  /// All the `objects` for the notifications for a `name`.
  @available(iOS 18, macOS 15, tvOS 18, visionOS 2, watchOS 11, *)
  static subscript<Object>(name: Notification.Name) -> some AsyncSequence<Object, Never> {
    NotificationCenter.default.notifications(named: name)
      .compactMap { $0.object as? Object }
  }
}
