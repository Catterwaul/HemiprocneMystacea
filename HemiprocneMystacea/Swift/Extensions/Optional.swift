public extension Optional {
	/// If `self` is nil, `valueWhenNil` is assigned to `self`.
	///- Returns: The non-nil value of `self`
	mutating func assignedIfNil(@noescape valueWhenNil_get: () -> Wrapped) -> Wrapped {
		return self ?? {
			self = valueWhenNil_get()
			return self!
		}()
	}
}