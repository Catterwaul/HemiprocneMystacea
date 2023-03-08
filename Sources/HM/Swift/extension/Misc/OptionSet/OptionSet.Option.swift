/// An "option", represented by a single bit flag.
@propertyWrapper public struct OptionSetOption<Options: OptionSet>
where Options.RawValue: BinaryInteger {
  public init(_ bitFlagIndex: Options.RawValue) {
    wrappedValue = .init(rawValue: 1 << bitFlagIndex)
  }

  public let wrappedValue: Options
}

public extension OptionSetOption {
  /// An option with the next higher bit flag.
  init(after previous: Self) {
    wrappedValue = .init(rawValue: previous.wrappedValue.rawValue << 1)
  }
}

public extension OptionSet where RawValue: BinaryInteger {
  typealias Option = OptionSetOption<Self>
}
