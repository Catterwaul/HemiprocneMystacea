import Combine
import SwiftUI

public extension SceneStorage {
  /// A way to use `SceneStorage` with more types,
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

// MARK: - Data
/// - Warning: Not a good match for tvOS, due to severely limited local storage allowance.
public extension SceneStorage<Data>.Converter where Converted: Codable {
  init<Decoder: TopLevelDecoder, Encoder: TopLevelEncoder>(
    wrappedValue: Converted,
    _ key: String, store: UserDefaults? = nil,
    decoder: Decoder = JSONDecoder(), encoder: Encoder = JSONEncoder()
  )
  where Decoder.Input == Data, Encoder.Output == Data {
    func toStorage(_ converted: Converted) -> Value {
      (try? encoder.encode(converted)) ?? .init()
    }

    self.init(
      storage: .init(wrappedValue: toStorage(wrappedValue), key),
      fromStorage: { (try? decoder.decode(Converted.self, from: $0)) ?? wrappedValue },
      toStorage: toStorage
    )
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
