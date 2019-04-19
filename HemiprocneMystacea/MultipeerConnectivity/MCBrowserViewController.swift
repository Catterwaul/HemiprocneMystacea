import MultipeerConnectivity

public extension MCBrowserViewController {
  static func makeInitializer(
    session: MCSession,
    serviceType: String,
    peerCountRange: ClosedRange<Int>,
    handleFinish: @escaping (MCSession) -> Void
  ) -> () -> MCBrowserViewController {
    return {
      [ unowned session,
        delegate = PeerBrowserViewControllerDelegate(handleFinish: handleFinish)
      ] in
      let browserViewController = MCBrowserViewController(serviceType: serviceType, session: session)
      browserViewController.minimumNumberOfPeers = peerCountRange.lowerBound
      browserViewController.maximumNumberOfPeers = peerCountRange.upperBound
      browserViewController.delegate = delegate
      return browserViewController
    }
  }
}

//MARK:-
private final class PeerBrowserViewControllerDelegate: NSObject {
  init(handleFinish: @escaping (MCSession) -> Void) {
    self.handleFinish = handleFinish
    super.init()
  }

  private let handleFinish: (MCSession) -> Void
}

//MARK: MCBrowserViewControllerDelegate
extension PeerBrowserViewControllerDelegate: MCBrowserViewControllerDelegate {
  func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
    browserViewController.dismiss(animated: true) {
      [ unowned self,
        unowned session = browserViewController.session
      ] in
      self.handleFinish(session)
    }
  }

  func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
    browserViewController.dismiss(animated: true)
  }
}
