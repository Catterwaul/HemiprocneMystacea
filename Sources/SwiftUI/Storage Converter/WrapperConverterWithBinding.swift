import HM
import SwiftUI

@propertyWrapper public struct WrapperConverterWithBinding<
  Wrapper: wrappedValue_nonmutating_set,
  WrappedValue
> {
  public typealias Converter = WrapperConverter<Wrapper, WrappedValue>

  @Converter public var wrappedValue: WrappedValue

  public var projectedValue: Binding<WrappedValue> {
    .init(
      get: { wrappedValue },
      set: { wrappedValue = $0 }
    )
  }

  // MARK: internal
  init(
    wrapper: Wrapper,
    fromStorage: @escaping Converter.FromWrapper,
    toStorage: @escaping Converter.ToWrapper
  ) {
    _wrappedValue = .init(
      wrapper: wrapper,
      fromWrapper: fromStorage,
      toWrapper: toStorage
    )
  }
}

// MARK: - DynamicProperty
extension WrapperConverterWithBinding: DynamicProperty where Wrapper: DynamicProperty { }
