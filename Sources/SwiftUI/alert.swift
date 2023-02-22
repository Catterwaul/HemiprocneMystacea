import protocol HM.ReconstitutablePropertyWrapper
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
    @Binding(data) var data
    return alert(
      title,
      isPresented: .init(
        get: { data != nil },
        set: { _ in data = nil }
      ),
      presenting: data,
      actions: actions,
      message: message
    )
  }
}
