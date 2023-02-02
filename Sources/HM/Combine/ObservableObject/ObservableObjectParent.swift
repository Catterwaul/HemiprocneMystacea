import Combine

/// An `ObservableObject` that has other `ObservableObject`s
/// forward their `objectWillChange`s through its own.
public protocol ObservableObjectParent: ObservableObject {
  associatedtype ObservableObjectChildren: Sequence<any ObservableObject>

  /// The children that need their `objectWillChange`s forwarded.
  var observableObjectChildren: ObservableObjectChildren { get }
}

public extension ObservableObjectParent {
  var observableObjectChildren: [any ObservableObject] {
    Mirror(reflecting: self).children.compactMap {
      $0.value as? any ObservableObject
    }
  }

  /// All child `ObservableObjects`' `objectWillChange`s.
  var childrenObjectWillChanges: [ObservableObjectPublisher] {
    observableObjectChildren.compactMap {
      $0.objectWillChange as any Publisher as? ObservableObjectPublisher
    }
  }
}
