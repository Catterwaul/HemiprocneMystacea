import Algorithms

/// A cipher between numbers and strings.
/// - Precondition: `allCases` is sorted.
public protocol NumericCipher: RawRepresentable & CaseIterable
where RawValue: BinaryInteger, AllCases: BidirectionalCollection { }

public extension Array where Element: NumericCipher {
  init(_ number: Element.RawValue) {
    self = .init(
      sequence(
        state: (remainder: number, index: Element.allCases.indices.last!)
      ) { state in
        guard let (index, element) = Element.allCases.indexed()
          .prefix(through: state.index)
          .last(where: { $0.element.rawValue <= state.remainder })
        else { return nil }

        state.remainder -= element.rawValue
        state.index = index
        return element
      }
    )
  }
}

public extension String {
  init(_ cipher: some Sequence<some NumericCipher>) {
    self = cipher.map { "\($0)" }.joined()
  }
}


// MARK: - RomanNumeral
public enum RomanNumeral: Int {
  case  i =    1
  case iv =    4
  case  v =    5
  case  x =   10
  case xl =   40
  case  l =   50
  case xc =   90
  case  c =  100
  case cd =  400
  case  d =  500
  case cm =  900
  case  m = 1000
}

extension RomanNumeral: CustomStringConvertible {
  public var description: String {
    switch self {
    case .i: return "I"
    case .iv: return "\(Self.i)\(Self.v)"
    case .v: return "V"
    case .x: return "X"
    case .xl: return "\(Self.x)\(Self.l)"
    case .l: return "L"
    case .xc: return "\(Self.x)\(Self.c)"
    case .c: return "C"
    case .cd: return "\(Self.c)\(Self.d)"
    case .d: return "D"
    case .cm: return "\(Self.c)\(Self.m)"
    case .m: return "M"
    }
  }
}

extension RomanNumeral: NumericCipher { }
