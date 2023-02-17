import Combine
import SwiftUI

public extension AppStorage {
  /// A way to use `AppStorage` with more types,
  /// via conversion to and from the limited supported types.
  typealias Converter<Converted> = StorageConverter<Self, Converted>
}

// MARK: - StorageDynamicProperty
extension AppStorage: StorageDynamicProperty { }

// MARK: - Data
@available(
  swift, deprecated: 5.8,
  message: "The where clause is redundant."
)
public extension AppStorage<Data>.Converter where Converted: Codable, Storage == AppStorage<Data> {
  /// - Warning: Not a good match for tvOS, due to severely limited local storage allowance.
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
      storage: .init(wrappedValue: toStorage(wrappedValue), key, store: store),
      fromStorage: { (try? decoder.decode(Converted.self, from: $0)) ?? wrappedValue },
      toStorage: toStorage
    )
  }
}

// MARK: - Double
@available(
  swift, deprecated: 5.8,
  message: "The where clause is redundant."
)
public extension AppStorage<Double>.Converter where Storage == AppStorage<Double> {
  init(
    wrappedValue: Converted,
    _ key: String,
    store: UserDefaults? = nil,
    fromStorage: @escaping FromStorage,
    toStorage: @escaping ToStorage
  ) {
    self.init(
      storage: .init(wrappedValue: toStorage(wrappedValue), key, store: store),
      fromStorage: fromStorage, toStorage: toStorage
    )
  }
}

public extension AppStorage<Double>.Converter<Date> {
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
