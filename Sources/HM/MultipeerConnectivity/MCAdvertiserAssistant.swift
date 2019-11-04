import MultipeerConnectivity

public extension MCAdvertiserAssistant {
  /// An `MCAdvertiserAssistant` and a delegate for it are created when this method is called.
  /// They're stored in the returned closure, which is the equivalent of the `Assistant`'s `start` method.
  ///
  /// - Parameters:
  ///   - handleFinish: Called when the `Assistant` is dismissed
  ///
  /// - Returns: `MCAdvertiserAssistant.start`
  static func makeStart(
    session: MCSession,
    serviceType: String,
    handleFinish: @escaping (MCSession) -> Void
  ) -> () -> Void {
    let assistant = MCAdvertiserAssistant(
      serviceType: serviceType,
      discoveryInfo: nil,
      session: session
    )
    let delegate = AdvertiserAssistantDelegate(handleFinish: handleFinish)
    assistant.delegate = delegate

    return { [delegate] in
      _ = delegate
      assistant.start()
    }
  }
}

//MARK:-
private final class AdvertiserAssistantDelegate: NSObject {
  init(handleFinish: @escaping (MCSession) -> Void) {
    self.handleFinish = handleFinish
    super.init()
  }

  private let handleFinish: (MCSession) -> Void
}

//MARK: MCAdvertiserAssistantDelegate
extension AdvertiserAssistantDelegate: MCAdvertiserAssistantDelegate {
  func advertiserAssistantDidDismissInvitation(_ advertiserAssistant: MCAdvertiserAssistant) {
    advertiserAssistant.stop()
    handleFinish(advertiserAssistant.session)
  }
}
