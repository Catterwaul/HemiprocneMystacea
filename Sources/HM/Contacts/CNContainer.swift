import Contacts

extension CNContainer {
  var isICloud: Bool {
    type == .cardDAV
    && name == "Card"
  }
}
