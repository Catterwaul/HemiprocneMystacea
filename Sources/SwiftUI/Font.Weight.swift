import SwiftUI

// MARK: - CaseIterable
extension Font.Weight: @retroactive CaseIterable {
  @available(macOS, deprecated: 15, message: "It's that time of year—check for new cases!")
  public static var allCases: [Self] {
    [ ultraLight,
      thin,
      light,
      regular,
      medium,
      semibold,
      bold,
      heavy,
      black
    ]
  }
}

// MARK: - CustomStringConvertible
extension Font.Weight: @retroactive CustomStringConvertible {
  @available(macOS, deprecated: 15, message: "It's that time of year—check for new cases!")
  public var description: String {
    switch self {
    case .ultraLight: return "ultraLight"
    case .thin: return "thin"
    case .light: return "light"
    case .regular: return "regular"
    case .medium: return "medium"
    case .semibold: return "semibold"
    case .bold: return "bold"
    case .heavy: return "heavy"
    case .black: return "black"
    default: return "\(self)"
    }
  }
}
