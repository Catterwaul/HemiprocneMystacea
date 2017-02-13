public extension Mirror {
	var reflectsOptionalNone: Bool {
		switch displayStyle {
		case .some(.optional): return children.isEmpty
		default: return false
		}
	}
}
