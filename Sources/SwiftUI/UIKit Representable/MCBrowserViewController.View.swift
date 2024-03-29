#if !os(macOS) && canImport(MultipeerConnectivity)
import Combine
import MultipeerConnectivity
import protocol SwiftUI.UIViewControllerRepresentable

public extension MCBrowserViewController {
  final class View: NSObject {
    public init(
      serviceType: String,
      session: MCSession,
      peerCountRange: ClosedRange<Int>? = nil
    ) {
      self.serviceType = serviceType
      self.session = session
      self.peerCountRange = peerCountRange
    }

    private let serviceType: String
    private unowned let session: MCSession
    private let peerCountRange: ClosedRange<Int>?

    private let didFinishSubject = CompletionSubject()
    private let wasCancelledSubject = CompletionSubject()
  }
}

// MARK: - public
public extension MCBrowserViewController.View {
  var didFinishPublisher: some Publisher<Void, Never> { didFinishSubject }
  var wasCancelledPublisher: some Publisher<Void, Never> { wasCancelledSubject }
}

// MARK: - private
private extension MCBrowserViewController {
  private typealias CompletionSubject = PassthroughSubject<Void, Never>
}

// MARK: - UIViewControllerRepresentable
extension MCBrowserViewController.View: UIViewControllerRepresentable {
  public func makeUIViewController(context: Context) -> MCBrowserViewController {
    let browser = MCBrowserViewController(
      serviceType: serviceType,
      session: session
    )

    browser.delegate = self

    if let peerCountRange {
      browser.minimumNumberOfPeers = peerCountRange.lowerBound
      browser.maximumNumberOfPeers = peerCountRange.upperBound
    }

    return browser
  }
}

// MARK: - MCBrowserViewControllerDelegate
extension MCBrowserViewController.View: MCBrowserViewControllerDelegate {
  public func browserViewControllerDidFinish(_: MCBrowserViewController) {
    didFinishSubject.send()
  }

  public func browserViewControllerWasCancelled(_: MCBrowserViewController) {
    wasCancelledSubject.send()
  }
}
#endif
