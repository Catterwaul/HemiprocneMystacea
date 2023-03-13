import Foundation

public extension NotificationCenter {
  /// All the `objects` for the notifications for a `name`.
  static subscript<Object>(name: Notification.Name) -> AsyncCompactMapSequence<Notifications, Object> {
    NotificationCenter.default.notifications(named: name)
      .compactMap { $0.object as? Object }
  }
}
