import HM
import SwiftUI

public extension ObservableObjectCollection {
  @propertyWrapper struct DynamicProperty<
    DynamicProperty: DynamicObservableObjectProperty<ObservableObjectCollection>
  >: SwiftUI.DynamicProperty {
    @MainActor public var wrappedValue: Objects {
      get { objects.wrappedValue }
      nonmutating set { objects.wrappedValue = newValue }
    }

    @MainActor public var projectedValue: Binding<Objects> { $objects.wrappedValue }

    @Rewrapper<DynamicProperty> private var objects: DynamicProperty.WrappedValue
  }
}

public extension ObservableObjectCollection.DynamicProperty {
  init(property: DynamicProperty) {
    _objects = .init(property)
  }
}

// MARK: -

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

// MARK: -

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

// MARK: - 

public protocol DynamicObservableObjectProperty<WrappedValue>: DynamicProperty & PropertyWrapper
where
  WrappedValue: ObservableObject,
  ProjectedValue == ObservedObject<WrappedValue>.Wrapper
{
  var wrappedValue: WrappedValue { get }
  var projectedValue: ProjectedValue { get }
}


extension ObservedObject: DynamicObservableObjectProperty { }
extension StateObject: DynamicObservableObjectProperty { }
