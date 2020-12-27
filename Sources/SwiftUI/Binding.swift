import SwiftUI

public extension Binding {
  subscript<Key, Value_Value>(
    key: Key,
    default default: Value_Value
  ) -> Binding<Value_Value>
  where Value == [Key: Value_Value] {
    .init(
      get: { wrappedValue[key, default: `default`] },
      set: { wrappedValue[key] = $0 }
    )
  }
}
