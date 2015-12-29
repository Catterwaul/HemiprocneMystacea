import Contacts

@available(iOS 9.0, *)
extension CNContainer {
   var isICloud: Bool {return type == .CardDAV && name == "Card"}
}