import SwiftUI

public extension SceneStorage {
  /// A way to use `AppStorage` with more types,
  /// via conversion to and from the limited supported types.
  @propertyWrapper struct Converter<Converted> {
    public typealias ToStorage = (Converted) -> Value
    public typealias FromStorage = (Value) -> Converted

    public var wrappedValue: Converted {
      get { fromStorage(storage) }
      nonmutating set { storage = toStorage(newValue) }
    }

    public var projectedValue: Binding<Converted> {
      .init(
        get: { wrappedValue },
        set: { wrappedValue = $0 }
      )
    }

    // MARK: private
    @SceneStorage private var storage: Value
    private let fromStorage: FromStorage
    private let toStorage: ToStorage

    private init(
      storage: SceneStorage,
      fromStorage: @escaping FromStorage,
      toStorage: @escaping ToStorage
    ) {
      _storage = storage
      self.toStorage = toStorage
      self.fromStorage = fromStorage
    }
  }
}

// MARK: - Double
public extension SceneStorage<Double>.Converter {
  init(
    wrappedValue: Converted,
    _ key: String,
    store: UserDefaults? = nil,
    fromStorage: @escaping FromStorage,
    toStorage: @escaping ToStorage
  ) {
    self.init(
      storage: .init(wrappedValue: toStorage(wrappedValue), key),
      fromStorage: fromStorage, toStorage: toStorage
    )
  }
}

public extension SceneStorage<Double>.Converter<Date> {
  init(
    wrappedValue: Converted,
    _ key: String,
    store: UserDefaults? = nil
  ) {
    self.init(
      wrappedValue: wrappedValue,
      key,
      store: store,
      fromStorage: Date.init(timeIntervalSinceReferenceDate:),
      toStorage: \.timeIntervalSinceReferenceDate
    )
  }
}

// MARK: - DynamicProperty
extension SceneStorage.Converter: DynamicProperty { }
