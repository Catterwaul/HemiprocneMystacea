import typealias Combine.ObservableObjectPublisher
import HM
import SwiftUI

// MARK: -

@propertyWrapper
public struct ObservedObjects<Objects: Sequence>: DynamicProperty
where
  Objects.Element: ObservableObject,
  Objects.Element.ObjectWillChangePublisher == ObservableObjectPublisher
{
  public init(wrappedValue: Objects) {
    _objects = .init(
      wrappedValue: .init(wrappedValue: wrappedValue)
    )
  }

  public var wrappedValue: Objects {
    get { objects.wrappedValue }
    nonmutating set { objects.wrappedValue = newValue }
  }

  public var projectedValue: Binding<Objects> { $objects.wrappedValue }

  @ObservedObject private var objects: ObservableObjects<Objects>
}

@propertyWrapper
public struct StateObjects<Objects: Sequence>: DynamicProperty
where
  Objects.Element: ObservableObject,
  Objects.Element.ObjectWillChangePublisher == ObservableObjectPublisher
{
  public init(wrappedValue: Objects) {
    _objects = .init(
      wrappedValue: .init(wrappedValue: wrappedValue)
    )
  }

  public var wrappedValue: Objects {
    get { objects.wrappedValue }
    nonmutating set { objects.wrappedValue = newValue }
  }

  public var projectedValue: Binding<Objects> { $objects.wrappedValue }

  @StateObject private var objects: ObservableObjects<Objects>
}
