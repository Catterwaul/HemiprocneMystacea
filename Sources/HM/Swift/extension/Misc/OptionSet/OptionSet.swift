public extension OptionSet {
  init(_ compatibleRawRepresentable: some RawRepresentable<RawValue>) {
    self.init(rawValue: compatibleRawRepresentable.rawValue)
  }

  init(_ option: some RawRepresentable<some RawRepresentable<RawValue>>) {
    self.init(rawValue: option.rawValue.rawValue)
  }

  init(rawValues: some Sequence<RawValue>) {
    self = []
    rawValues.forEach { formUnion(.init(rawValue: $0)) }
  }

  init(_ rawValues: some Sequence<some RawRepresentable<some RawRepresentable<RawValue>>>) {
    self.init(rawValues: rawValues.map(\.rawValue.rawValue))
  }
}

public extension OptionSet where RawValue: BinaryInteger {
  /// Provides two options.
  ///
  ///- Parameter startingFlagIndex: shifts 0b11 if > 0
  static subscript(startingFlagIndex startingFlagIndex: RawValue = 0) -> (
    Self,
    Self
  ) {
    ( .init(flagIndex: startingFlagIndex),
      .init(flagIndex: startingFlagIndex + 1)
    )
  }
  
  /// Provides three options.
  ///
  ///- Parameter startingFlagIndex: shifts 0b111 if > 0
  static subscript(startingFlagIndex startingFlagIndex: RawValue = 0) -> (
    Self, Self,
    Self
  ) {
    Tuple[
      Self[startingFlagIndex: startingFlagIndex],
      .init(flagIndex: startingFlagIndex + 2)
    ]
  }
  
  /// Provides four options.
  ///
  ///- Parameter startingFlagIndex: shifts 0b1111 if > 0
  static subscript(startingFlagIndex startingFlagIndex: RawValue = 0) -> (
    Self, Self, Self,
    Self
  ) {
    Tuple[
      Self[startingFlagIndex: startingFlagIndex],
      .init(flagIndex: startingFlagIndex + 3)
    ]
  }
  
  /// Provides five options.
  ///
  ///- Parameter startingFlagIndex: shifts 0b1_1111 if > 0
  static subscript(startingFlagIndex startingFlagIndex: RawValue = 0) -> (
    Self, Self, Self, Self,
    Self
  ) {
    Tuple[
      Self[startingFlagIndex: startingFlagIndex],
      .init(flagIndex: startingFlagIndex + 4)
    ]
  }
  
  /// Provides six options.
  ///
  ///- Parameter startingFlagIndex: shifts 0b11_1111 if > 0
  static subscript(startingFlagIndex startingFlagIndex: RawValue = 0) -> (
    Self, Self, Self, Self, Self,
    Self
  ) {
    Tuple[
      Self[startingFlagIndex: startingFlagIndex],
      .init(flagIndex: startingFlagIndex + 5)
    ]
  }
}

// MARK: private
private extension OptionSet where RawValue: BinaryInteger {
  private init(flagIndex: RawValue) {
    self.init(rawValue: 1 << flagIndex)
  }
}
