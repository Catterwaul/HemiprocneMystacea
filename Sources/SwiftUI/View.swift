import SwiftUI

public extension View {
  var inAllColorSchemes: some View {
    ForEach(
      ColorScheme.allCases,
      id: \.self,
      content: preferredColorScheme
    )
  }

  /// Execute imperative code.
  func callAsFunction(_ execute: () -> Void) -> Self {
    execute()
    return self
  }
  
  /// Modify a view with a `ViewBuilder` closure.
  ///
  /// This represents a streamlining of the
  /// [`modifier`](https://developer.apple.com/documentation/swiftui/view/modifier(_:))
  /// \+ [`ViewModifier`](https://developer.apple.com/documentation/swiftui/viewmodifier)
  /// pattern.
  /// - Note: Useful only when you don't need to reuse the closure.
  /// If you do, turn the closure into an extension! ♻️
  func modifier<ModifiedContent: View>(
    @ViewBuilder body: (_ content: Self) -> ModifiedContent
  ) -> ModifiedContent {
    body(self)
  }
}

/// A workaround for `do/catch` statements not working with result builders.
@ViewBuilder public func `do`(
  @ViewBuilder try success: () throws -> some View,
  @ViewBuilder catch failure: (any Error) -> some View
) -> some View {
  switch Result(catching: success) {
  case .success(let success): success
  case .failure(let error): failure(error)
  }
}
