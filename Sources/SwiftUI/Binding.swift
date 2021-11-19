import HM
import struct SwiftUI.Binding

public extension Binding {
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
