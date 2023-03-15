public extension RawRepresentable
where RawValue: RawRepresentable, RawValue.RawValue: FixedWidthInteger {
  typealias Set = BitFlagRepresentableOptionSet<Self>
}

public struct BitFlagRepresentableOptionSet<BitFlagRepresentable: RawRepresentable>: OptionSet
where
BitFlagRepresentable.RawValue: RawRepresentable,
BitFlagRepresentable.RawValue.RawValue: FixedWidthInteger {
  public typealias RawValue = BitFlagRepresentable.RawValue.RawValue

  public init(rawValue: RawValue) {
    self.rawValue = rawValue
  }

  public let rawValue: RawValue
}

// MARK: - public
public extension BitFlagRepresentableOptionSet {
  init(_ bitFlagRepresentable: BitFlagRepresentable) {
    self.init(rawValue: bitFlagRepresentable.rawValue.rawValue)
  }
}

// MARK: - Array
public extension Array where
Element: RawRepresentable,
Element.RawValue: FixedWidthInteger & _ExpressibleByBuiltinIntegerLiteral {
  init<OptionSet: Swift.OptionSet>(_ optionSet: OptionSet) where
  OptionSet.RawValue == Element.RawValue {
    self =
    optionSet.rawValue == 0 ? []
    : (
      optionSet.rawValue.trailingZeroBitCount
      ..<
      OptionSet.RawValue.bitWidth - optionSet.rawValue.leadingZeroBitCount
    ).compactMap {
      .init(rawValue: optionSet.rawValue & 1 << $0)
    }
  }
}

public extension Array where
Element: RawRepresentable,
Element.RawValue: RawRepresentable,
Element.RawValue.RawValue: FixedWidthInteger & _ExpressibleByBuiltinIntegerLiteral {
  init<OptionSet: Swift.OptionSet>(_ optionSet: OptionSet)
  where OptionSet.RawValue == Element.RawValue.RawValue {
    self = [BitFlag](optionSet).compactMap {
      Element.RawValue(rawValue: $0.rawValue).flatMap(Element.init)
    }
  }
}
