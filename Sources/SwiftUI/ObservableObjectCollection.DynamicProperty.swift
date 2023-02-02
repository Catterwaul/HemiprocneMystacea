import typealias Combine.ObservableObjectPublisher
import HM
import SwiftUI

public extension ObservableObjectCollection {
  @propertyWrapper struct DynamicProperty<
    DynamicProperty: DynamicObservableObjectProperty<ObservableObjectCollection>
  >: SwiftUI.DynamicProperty {
    @MainActor public var wrappedValue: Objects {
      get { objects.wrappedValue.wrappedValue }
      nonmutating set { objects.wrappedValue.wrappedValue = newValue }
    }

    @MainActor public var projectedValue: Binding<Objects> { objects.projectedValue.wrappedValue }

    private let objects: DynamicProperty
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
      objects: .init(
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
      objects: .init(
        wrappedValue: .init(wrappedValue: wrappedValue)
      )
    )
  }
}

// MARK: - 

public protocol DynamicObservableObjectProperty<ObjectType>: DynamicProperty {
  associatedtype ObjectType: ObservableObject
  @MainActor var wrappedValue: ObjectType { get }
  @MainActor var projectedValue: ObservedObject<ObjectType>.Wrapper { get }
}


extension ObservedObject: DynamicObservableObjectProperty { }
extension StateObject: DynamicObservableObjectProperty { }
