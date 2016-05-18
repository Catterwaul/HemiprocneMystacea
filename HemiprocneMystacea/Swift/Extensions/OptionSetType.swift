public extension OptionSetType where RawValue: BitShiftable {
	/// Provides two options.
	///
	///- Parameter startingIndex: shifts 0b11 if > 1
	static func Flags(startingIndex startingIndex: RawValue = 1) -> (
		Self,
		Self
	) {
		return (
			Self(flagIndex: startingIndex),
			Self(flagIndex: startingIndex + 1)
		)
	}
	
	/// Provides three options.
	///
	///- Parameter startingIndex: shifts 0b111 if > 1
	static func Flags(startingIndex startingIndex: RawValue = 1) -> (
		Self,
		Self,
		Self
	) {
		return (
			Self(flagIndex: startingIndex),
			Self(flagIndex: startingIndex + 1),
			Self(flagIndex: startingIndex + 2)
		)
	}
	
	/// Provides four options.
	///
	///- Parameter startingIndex: shifts 0b1111 if > 1
	static func Flags(startingIndex startingIndex: RawValue = 1) -> (
		Self,
		Self,
		Self,
		Self
	) {
		return (
			Self(flagIndex: startingIndex),
			Self(flagIndex: startingIndex + 1),
			Self(flagIndex: startingIndex + 2),
			Self(flagIndex: startingIndex + 3)
		)
	}
	
	/// Provides five options.
	///
	///- Parameter startingIndex: shifts 0b1_1111 if > 1
	static func Flags(startingIndex startingIndex: RawValue = 1) -> (
		Self,
		Self,
		Self,
		Self,
		Self
	) {
		return (
			Self(flagIndex: startingIndex),
			Self(flagIndex: startingIndex + 1),
			Self(flagIndex: startingIndex + 2),
			Self(flagIndex: startingIndex + 3),
			Self(flagIndex: startingIndex + 4)
		)
	}
	
	/// Provides six options.
	///
	///- Parameter startingIndex: shifts 0b11_1111 if > 1
	static func Flags(startingIndex startingIndex: RawValue = 1) -> (
		Self,
		Self,
		Self,
		Self,
		Self,
		Self
	) {
		return (
			Self(flagIndex: startingIndex),
			Self(flagIndex: startingIndex + 1),
			Self(flagIndex: startingIndex + 2),
			Self(flagIndex: startingIndex + 3),
			Self(flagIndex: startingIndex + 4),
			Self(flagIndex: startingIndex + 5)
		)
	}
}
private extension OptionSetType where RawValue: BitShiftable {
	init(flagIndex: RawValue) {
		self.init(
			rawValue: flagIndex <= 1
				? flagIndex
				: 1 << (flagIndex - 1)
		)
	}
}