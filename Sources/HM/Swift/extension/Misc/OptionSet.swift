public extension OptionSet {
  init<CompatibleOptionSet: OptionSet>(_ compatibleOptionSet: CompatibleOptionSet)
  where CompatibleOptionSet.RawValue == RawValue {
    self.init(rawValue: compatibleOptionSet.rawValue)
  }
}

public extension OptionSet where RawValue: FixedWidthInteger {
	/// Provides two options.
	///
	///- Parameter startingFlagIndex: shifts 0b11 if > 1
	static func makeOptions(startingFlagIndex: RawValue = 1) -> (
		Self,
		Self
	) {
    ( Self(flagIndex: startingFlagIndex),
			Self(flagIndex: startingFlagIndex + 1)
		)
	}
	
	/// Provides three options.
	///
	///- Parameter startingFlagIndex: shifts 0b111 if > 1
	static func makeOptions(startingFlagIndex: RawValue = 1) -> (
		Self,
		Self,
		Self
	) {
    ( Self(flagIndex: startingFlagIndex),
			Self(flagIndex: startingFlagIndex + 1),
			Self(flagIndex: startingFlagIndex + 2)
		)
	}
	
	/// Provides four options.
	///
	///- Parameter startingFlagIndex: shifts 0b1111 if > 1
	static func makeOptions(startingFlagIndex: RawValue = 1) -> (
		Self,
		Self,
		Self,
		Self
	) {
    ( Self(flagIndex: startingFlagIndex),
			Self(flagIndex: startingFlagIndex + 1),
			Self(flagIndex: startingFlagIndex + 2),
			Self(flagIndex: startingFlagIndex + 3)
		)
	}
	
	/// Provides five options.
	///
	///- Parameter startingFlagIndex: shifts 0b1_1111 if > 1
	static func makeOptions(startingFlagIndex: RawValue = 1) -> (
		Self,
		Self,
		Self,
		Self,
		Self
	) {
    ( Self(flagIndex: startingFlagIndex),
			Self(flagIndex: startingFlagIndex + 1),
			Self(flagIndex: startingFlagIndex + 2),
			Self(flagIndex: startingFlagIndex + 3),
			Self(flagIndex: startingFlagIndex + 4)
		)
	}
	
	/// Provides six options.
	///
	///- Parameter startingFlagIndex: shifts 0b11_1111 if > 1
	static func makeOptions(startingFlagIndex: RawValue = 1) -> (
		Self,
		Self,
		Self,
		Self,
		Self,
		Self
	) {
    ( Self(flagIndex: startingFlagIndex),
			Self(flagIndex: startingFlagIndex + 1),
			Self(flagIndex: startingFlagIndex + 2),
			Self(flagIndex: startingFlagIndex + 3),
			Self(flagIndex: startingFlagIndex + 4),
			Self(flagIndex: startingFlagIndex + 5)
		)
	}
}

//MARK: private
private extension OptionSet where RawValue: BinaryInteger {
	init(flagIndex: RawValue) {
		self.init(rawValue: 1 << (flagIndex - 1))
	}
}
