public extension RawRepresentable {
	static func contains(_ rawValue: RawValue) -> Bool {
		return Self.init(rawValue: rawValue) != nil
	}
}
