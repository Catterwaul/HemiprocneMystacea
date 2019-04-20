import MultipeerConnectivity

extension MCSession {
  open class Delegate: NSObject {
    public init(session: MCSession) {
      self.session = session
      super.init()
      session.delegate = self
    }

  //MARK: protected
    public unowned let session: MCSession
  }
}

//MARK: MCSessionDelegate
extension MCSession.Delegate: MCSessionDelegate {
  open func session(_: MCSession, didReceive data: Data, fromPeer _: MCPeerID) { }
  open func session(_: MCSession, peer _: MCPeerID, didChange _: MCSessionState) { }
  open func session(_: MCSession, didReceive _: InputStream, withName _: String, fromPeer _: MCPeerID) { }
  open func session(_: MCSession, didStartReceivingResourceWithName _: String, fromPeer _: MCPeerID, with _: Progress) { }
  open func session(_: MCSession, didFinishReceivingResourceWithName _: String, fromPeer _: MCPeerID, at _: URL?, withError _: Error?) { }
}
