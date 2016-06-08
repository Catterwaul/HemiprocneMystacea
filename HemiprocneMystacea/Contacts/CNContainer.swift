import Contacts

extension CNContainer {
	var isICloud: Bool {
		return type == .CardDAV
			&& name == "Card"
	}
}