import Foundation

public extension NotificationCenter {
  /// All the `objects` for the notifications for a `name`.
  @available(macOS 15.0, iOS 18.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
  static subscript<Object>(name: Notification.Name) -> some AsyncSequence<Object, Never> {
    NotificationCenter.default.notifications(named: name)
      .compactMap { $0.object as? Object }
  }
}
