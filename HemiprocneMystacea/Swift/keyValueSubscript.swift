/// Acts as a dictionary
public protocol keyValueSubscript {
	associatedtype Key
	associatedtype Value
	
	subscript(key: Key) -> Value? {get}
}

public extension keyValueSubscript {
	/// Should just be a generic subscript, but those don't exist yet.
	func getValue<Value>(key: Key) -> Value? {
		return self[key] as? Value
	}
	
	/// Allows lookup by enumeration cases backed by `Key`s,
	/// instead of having to manually use their raw values.
	///
	/// Should just be a generic subscript, but those don't exist yet.
	func getValue<
		Key: RawRepresentable,
		Value
	>(key: Key) -> Value?
	where Key.RawValue == Self.Key {
		return self.getValue(key: key.rawValue)
	}
}

/// Acts as a dictionary that `throw`s instead of returning optionals.
public protocol keyValueThrowingSubscript {
	associatedtype Key
	
	/// Should just be a generic, throwing subscript, but those don't exist yet.
	func getValue<Value>(key: Key) throws -> Value
}

public extension keyValueThrowingSubscript {
	/// Allows lookup by enumeration cases backed by `Key`s,
	/// instead of having to manually use their raw values.
	///
	/// Should just be a generic, throwing subscript, but those don't exist yet.
	func getValue<
		Key: RawRepresentable,
		Value
	>(key: Key) throws -> Value
	where Key.RawValue == Self.Key {
		return try self.getValue(key: key.rawValue)
	}
}
