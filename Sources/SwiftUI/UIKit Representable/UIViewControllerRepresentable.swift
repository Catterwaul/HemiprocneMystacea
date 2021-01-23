#if !os(macOS)
import protocol SwiftUI.UIViewControllerRepresentable

public extension UIViewControllerRepresentable {
  func updateUIViewController(_: UIViewControllerType, context _: Context) { }
}
#endif
