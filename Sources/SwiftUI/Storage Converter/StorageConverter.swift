import SwiftUI

@propertyWrapper public struct StorageConverter<Storage: StorageDynamicProperty, Converted> {
  public typealias ToStorage = (Converted) -> Storage.Value
  public typealias FromStorage = (Storage.Value) -> Converted

  public var wrappedValue: Converted {
    get { fromStorage(storage.wrappedValue) }
    nonmutating set { storage.wrappedValue = toStorage(newValue) }
  }

  public var projectedValue: Binding<Converted> {
    .init(
      get: { wrappedValue },
      set: { wrappedValue = $0 }
    )
  }

  // MARK: internal
  init(
    storage: Storage,
    fromStorage: @escaping FromStorage,
    toStorage: @escaping ToStorage
  ) {
    self.storage = storage
    self.toStorage = toStorage
    self.fromStorage = fromStorage
  }

  // MARK: private
  private let storage: Storage
  private let fromStorage: FromStorage
  private let toStorage: ToStorage
}

public protocol StorageDynamicProperty<Value>: DynamicProperty {
  associatedtype Value
  var wrappedValue: Value { get nonmutating set }
}

// MARK: - DynamicProperty
extension StorageConverter: DynamicProperty { }
