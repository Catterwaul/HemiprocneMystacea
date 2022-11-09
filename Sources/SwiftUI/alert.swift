import SwiftUI

public extension View {
  /// Combines the "`isPresented`" and "`presenting`" `alert` overloads.
  ///
  /// - Parameters:
  ///   - data: The alert will show up when this receives a value,
  ///   and it will be set to `nil` when dismissing the alert.
  func alert<Data>(
    _ title: some StringProtocol,
    presenting data: Binding<Data?>,
    @ViewBuilder actions: (Data) -> some View,
    @ViewBuilder message: (Data) -> some View
  ) -> some View {
    alert(
      title,
      isPresented: .init(
        get: { data.wrappedValue != nil },
        set: { _ in data.wrappedValue = nil }
      ),
      presenting: data.wrappedValue,
      actions: actions,
      message: message
    )
  }
}
