import Combine
import SwiftUI

public extension SceneStorage {
  /// A way to use `SceneStorage` with more types,
  /// via conversion to and from the limited supported types.
  typealias Converter<Converted> = StorageConverter<Self, Converted>
}

// MARK: - StorageDynamicProperty
extension SceneStorage: StorageDynamicProperty { }

// MARK: - Data
/// - Warning: Not a good match for tvOS, due to severely limited local storage allowance.
public extension SceneStorage<Data>.Converter where Converted: Codable, Storage == SceneStorage<Data> {
  init<Decoder: TopLevelDecoder, Encoder: TopLevelEncoder>(
    wrappedValue: Converted,
    _ key: String, store: UserDefaults? = nil,
    decoder: Decoder = JSONDecoder(), encoder: Encoder = JSONEncoder()
  )
  where Decoder.Input == Data, Encoder.Output == Data {
    func toStorage(_ converted: Converted) -> Data {
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
public extension AppStorage<Double>.Converter where Storage == SceneStorage<Double> {
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
