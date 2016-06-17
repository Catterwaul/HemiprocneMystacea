import Contacts

extension CNContainer {
	var isICloud: Bool {
		return type == .cardDAV
			&& name == "Card"
	}
}
