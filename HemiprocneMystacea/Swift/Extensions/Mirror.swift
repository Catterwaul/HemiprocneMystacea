public extension Mirror {
	var reflectsOptionalNone: Bool {
		switch displayStyle {
		case .optional?: return children.isEmpty
		default: return false
		}
	}
}
