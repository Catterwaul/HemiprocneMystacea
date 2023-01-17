#if !(os(macOS) || os(watchOS))
import protocol SwiftUI.UIViewRepresentable

public extension UIViewRepresentable {
  func updateUIView(_: UIViewType, context _: Context) { }
}
#endif
