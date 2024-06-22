import Combine
import protocol HM.wrappedValue_nonmutating_set
import SwiftUI

public extension AppStorage {
  /// A way to use `AppStorage` with more types,
  /// via conversion to and from the limited supported types.
  typealias Converter<WrappedValue> = WrapperConverterWithBinding<Self, WrappedValue>
}

// MARK: - wrappedValue_nonmutating_set
extension AppStorage: @retroactive wrappedValue_nonmutating_set {
  public typealias WrappedValue = Value
}

// MARK: - Data
@available(
  swift, deprecated: 6,
  message: "The where clause is redundant."
)
public extension AppStorage<Data>.Converter where WrappedValue: Codable, Wrapper == AppStorage<Data> {
  /// - Warning: Not a good match for tvOS, due to severely limited local storage allowance.
  init<Decoder: TopLevelDecoder, Encoder: TopLevelEncoder>(
    wrappedValue: WrappedValue,
    _ key: String, store: UserDefaults? = nil,
    decoder: Decoder = JSONDecoder(), encoder: Encoder = JSONEncoder()
  )
  where Decoder.Input == Data, Encoder.Output == Data {
    func toStorage(_ converted: WrappedValue) -> Data {
      (try? encoder.encode(converted)) ?? .init()
    }
    
    self.init(
      wrapper: .init(wrappedValue: toStorage(wrappedValue), key, store: store),
      fromStorage: { (try? decoder.decode(WrappedValue.self, from: $0)) ?? wrappedValue },
      toStorage: toStorage
    )
  }
}

// MARK: - Double
@available(
  swift, deprecated: 6,
  message: "The where clause is redundant."
)
public extension AppStorage<Double>.Converter where Wrapper == AppStorage<Double> {
  init(
    wrappedValue: WrappedValue,
    _ key: String,
    store: UserDefaults? = nil,
    fromStorage: @escaping Converter.FromWrapper,
    toStorage: @escaping Converter.ToWrapper
  ) {
    self.init(
      wrapper: .init(wrappedValue: toStorage(wrappedValue), key, store: store),
      fromStorage: fromStorage, toStorage: toStorage
    )
  }
}

public extension AppStorage<Double>.Converter<Date> {
  init(
    wrappedValue: WrappedValue,
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
