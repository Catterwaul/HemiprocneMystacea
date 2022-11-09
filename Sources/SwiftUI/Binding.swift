import HM
import struct SwiftUI.Binding

public extension Binding {
  static func ?? <Wrapped>(optional: Self, defaultValue: Wrapped) -> Binding<Wrapped>
  where Value == Wrapped? {
    .init(
      get: { optional.wrappedValue ?? defaultValue },
      set: { optional.wrappedValue = $0 }
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
  subscript<Key, Value_Value>(
    key: Key,
    default default: Value_Value
  ) -> Binding<Value_Value>
  where Value == [Key: Value_Value] {
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
