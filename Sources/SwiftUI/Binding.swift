import HM
import typealias SwiftUI.Binding

public extension Binding {
  /// A `Binding` whose `get` accessor returns a default value instead of `nil`.
  static func ?? (optional: Binding<Value?>, default: Value) -> Self {
    .init(
      get: { optional.wrappedValue ?? `default`},
      set: { optional.wrappedValue = $0
      }
    )
  }

  init(
    accessors: (
      get: () -> Value,
      set: (Value) -> Void
    )
  ) {
    self.init(get: accessors.get, set: accessors.set)
  }
  
  init<Root>(
    _ root: Root,
    keyPath: ReferenceWritableKeyPath<Root, Value>
  ) {
    self.init(accessors: keyPath.accessors(root))
  }
  
  /// Assign and return a `default` when the value for a key is `nil`.
  subscript<Key, DictionaryValue>(
    key: Key,
    default default: DictionaryValue
  ) -> Binding<DictionaryValue>
  where Value == [Key: DictionaryValue] {
    .init(
      get: {
        switch wrappedValue[key] {
        case let value?:
          return value
        case nil:
          wrappedValue[key] = `default`
          return `default`
        }
      },
      set: { wrappedValue[key] = $0 }
    )
  }
}

public extension Binding<Bool> {
  prefix static func !(binding: Self) -> Self {
    .init(
      get: { !binding.wrappedValue },
      set: { binding.wrappedValue = !$0 }
    )
  }
}
