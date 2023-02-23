import HM
import SwiftUI

public extension ObservableObjectCollection {
  /// A `Collection` of `ObservableObject`s that invalidate a view
  /// when changes are made to their `Published` properties.
  @propertyWrapper struct DynamicProperty<
    DynamicProperty: SwiftUI.DynamicProperty
      & wrappedValue<ObservableObjectCollection>
      & projectedValue<ObservedObject<DynamicProperty.WrappedValue>.Wrapper>
  > {
    @MainActor public var wrappedValue: Objects {
      get { objects.wrappedValue }
      nonmutating set { objects.wrappedValue = newValue }
    }

    @MainActor public var projectedValue: ObservedObject<DynamicProperty.WrappedValue>.Wrapper {
      $objects
    }

    @Rewrapper<DynamicProperty> private var objects: DynamicProperty.WrappedValue
  }
}

// MARK: - private
private extension ObservableObjectCollection.DynamicProperty {
  private init(property: DynamicProperty) {
    _objects = .init(property)
  }
}

// MARK: - SwiftUI.DynamicProperty
extension ObservableObjectCollection.DynamicProperty: SwiftUI.DynamicProperty { }

// MARK: - ObservedObject
public extension ObservedObject {
  typealias Collection<Objects> = ObservableObjectCollection<Objects>.DynamicProperty<Self>
  where ObjectType == ObservableObjectCollection<Objects>
}

@available(
  swift, deprecated: 5.8,
  message: "`where` clause will not compile with generic syntax instead"
)
public extension ObservableObjectCollection.DynamicProperty where DynamicProperty == ObservedObject<ObservableObjectCollection> {
  init(wrappedValue: Objects) {
    self.init(
      property: .init(
        wrappedValue: .init(wrappedValue: wrappedValue)
      )
    )
  }
}

extension ObservedObject: wrappedValue & projectedValue { }

// MARK: - StateObject
public extension StateObject {
  typealias Collection<Objects> = ObservableObjectCollection<Objects>.DynamicProperty<Self>
  where ObjectType == ObservableObjectCollection<Objects>
}

@available(
  swift, deprecated: 5.8,
  message: "`where` clause will not compile with generic syntax instead"
)
public extension ObservableObjectCollection.DynamicProperty where DynamicProperty == StateObject<ObservableObjectCollection> {
  init(wrappedValue: Objects) {
    self.init(
      property: .init(
        wrappedValue: .init(wrappedValue: wrappedValue)
      )
    )
  }
}

extension StateObject: wrappedValue & projectedValue { }
