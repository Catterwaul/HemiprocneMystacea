public extension Optional {
	/// If `self` is nil, `valueWhenNil` is assigned to `self`.
	///- Returns: The non-nil value of `self`
	mutating func assignedIfNil(
		_ getValueWhenNil: () -> Wrapped
	) -> Wrapped {
		return
			self
			??
      { self = getValueWhenNil()
				return self!
			}()
	}
}
