/// Convert one property wrapper to another.
@propertyWrapper public struct WrapperConverter<
  Wrapper: wrappedValue_nonmutating_set,
  WrappedValue
> {
  public typealias ToWrapper = (WrappedValue) -> Wrapper.WrappedValue
  public typealias FromWrapper = (Wrapper.WrappedValue) -> WrappedValue

  public var wrappedValue: WrappedValue {
    get { fromWrapper(wrapper.wrappedValue) }
    nonmutating set { wrapper.wrappedValue = toWrapper(newValue) }
  }

  public init(
    wrapper: Wrapper,
    fromWrapper: @escaping FromWrapper,
    toWrapper: @escaping ToWrapper
  ) {
    self.wrapper = wrapper
    self.fromWrapper = fromWrapper
    self.toWrapper = toWrapper
  }

  // MARK: private
  private let wrapper: Wrapper
  private let fromWrapper: FromWrapper
  private let toWrapper: ToWrapper
}
