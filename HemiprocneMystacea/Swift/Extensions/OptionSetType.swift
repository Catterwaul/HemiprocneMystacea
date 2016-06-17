public extension OptionSet where RawValue: BitShiftable {
	/// Provides two options.
	///
	///- Parameter startingFlagIndex: shifts 0b11 if > 1
	static func selfs(startingFlagIndex: RawValue = 1) -> (
		Self,
		Self
	) {
		return (
			Self(flagIndex: startingFlagIndex),
			Self(flagIndex: startingFlagIndex + 1)
		)
	}
	
	/// Provides three options.
	///
	///- Parameter startingFlagIndex: shifts 0b111 if > 1
	static func selfs(startingFlagIndex: RawValue = 1) -> (
		Self,
		Self,
		Self
	) {
		return (
			Self(flagIndex: startingFlagIndex),
			Self(flagIndex: startingFlagIndex + 1),
			Self(flagIndex: startingFlagIndex + 2)
		)
	}
	
	/// Provides four options.
	///
	///- Parameter startingFlagIndex: shifts 0b1111 if > 1
	static func selfs(startingFlagIndex: RawValue = 1) -> (
		Self,
		Self,
		Self,
		Self
	) {
		return (
			Self(flagIndex: startingFlagIndex),
			Self(flagIndex: startingFlagIndex + 1),
			Self(flagIndex: startingFlagIndex + 2),
			Self(flagIndex: startingFlagIndex + 3)
		)
	}
	
	/// Provides five options.
	///
	///- Parameter startingFlagIndex: shifts 0b1_1111 if > 1
	static func selfs(startingFlagIndex: RawValue = 1) -> (
		Self,
		Self,
		Self,
		Self,
		Self
	) {
		return (
			Self(flagIndex: startingFlagIndex),
			Self(flagIndex: startingFlagIndex + 1),
			Self(flagIndex: startingFlagIndex + 2),
			Self(flagIndex: startingFlagIndex + 3),
			Self(flagIndex: startingFlagIndex + 4)
		)
	}
	
	/// Provides six options.
	///
	///- Parameter startingFlagIndex: shifts 0b11_1111 if > 1
	static func selfs(startingFlagIndex: RawValue = 1) -> (
		Self,
		Self,
		Self,
		Self,
		Self,
		Self
	) {
		return (
			Self(flagIndex: startingFlagIndex),
			Self(flagIndex: startingFlagIndex + 1),
			Self(flagIndex: startingFlagIndex + 2),
			Self(flagIndex: startingFlagIndex + 3),
			Self(flagIndex: startingFlagIndex + 4),
			Self(flagIndex: startingFlagIndex + 5)
		)
	}
}
private extension OptionSet where RawValue: BitShiftable {
	init(flagIndex: RawValue) {
		self.init(
			rawValue: flagIndex <= 1
				? flagIndex
				: 1 << (flagIndex - 1)
		)
	}
}
