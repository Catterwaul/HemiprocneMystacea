import protocol Combine.ObservableObject
import HM
import SwiftUI

public extension ObservableObjectCollection {
  @propertyWrapper struct DynamicProperty<
    DynamicProperty: SwiftUI.DynamicProperty
      & wrappedValue<ObservableObjectCollection>
      & projectedValue<ObservedObject<DynamicProperty.WrappedValue>.Wrapper>
  > {
    @MainActor public var wrappedValue: Objects {
      get { objects.wrappedValue }
      nonmutating set { objects.wrappedValue = newValue }
    }

    @MainActor public var projectedValue: Binding<Objects> { $objects.wrappedValue }

    @Rewrapper<DynamicProperty> private var objects: DynamicProperty.WrappedValue
  }
}

// MARK: - public
public extension ObservableObjectCollection.DynamicProperty {
  init(property: DynamicProperty) {
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

extension ObservableObjectCollection.DynamicProperty where DynamicProperty == ObservedObject<ObservableObjectCollection> {
  public init(wrappedValue: Objects) {
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
