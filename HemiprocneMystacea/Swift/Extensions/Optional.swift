public extension Optional {
	/// If `self` is nil, `valueWhenNil` is assigned to `self`.
	///- Returns: The non-nil value of `self`
	mutating func assignedIfNil(
		_ get_valueWhenNil: () -> Wrapped
	) -> Wrapped {
		return self ?? {
			self = get_valueWhenNil()
			return self!
		}()
	}
}
