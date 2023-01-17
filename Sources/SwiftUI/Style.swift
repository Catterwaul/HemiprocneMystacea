import SwiftUI

/// A type-erased "`Style`".
public struct AnyStyle<Configuration> {
  private let makeBody: (Configuration) -> AnyView
}

// MARK: - public
public extension AnyStyle {
  init(makeBody: @escaping (Configuration) -> some View) {
    self.makeBody = { .init(makeBody($0)) }
  }

  func makeBody(configuration: Configuration) -> some View {
    makeBody(configuration)
  }
}

// MARK: - ButtonStyle
extension AnyStyle: ButtonStyle where Configuration == ButtonStyleConfiguration {
  public init(_ style: some ButtonStyle) {
    self.init(makeBody: style.makeBody)
  }
}

#if !os(watchOS)
// MARK: - GroupBoxStyle
extension AnyStyle: GroupBoxStyle where Configuration == GroupBoxStyleConfiguration {
  public init(_ style: some GroupBoxStyle) {
    self.init(makeBody: style.makeBody)
  }
}
#endif

// MARK: - LabelStyle
extension AnyStyle: LabelStyle where Configuration == LabelStyleConfiguration {
  public init(_ style: some LabelStyle) {
    self.init(makeBody: style.makeBody)
  }
}
