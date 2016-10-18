public protocol StringKeyDictionary {
	associatedtype Value
	
	subscript(key: String) -> Value? {get}
}

public extension StringKeyDictionary {
	/// Should just be a generic subscript, but those don't exist yet.
	func get_value<Value>(key: String) -> Value? {
		return self[key] as? Value
	}
	
	func get_value<
		Key: RawRepresentable,
		Value
	>(key: Key) -> Value?
	where Key.RawValue == String {
		return self.get_value(key: key.rawValue)
	}
}

public protocol StringKeyDictionary_throws {
	/// Should just be a generic, throwing subscript, but those don't exist yet.
	func get_value<Value>(key: String) throws -> Value
}

public extension StringKeyDictionary_throws {
	/// Should just be a generic, throwing subscript, but those don't exist yet.
	func get_value<
		Key: RawRepresentable,
		Value
	>(key: Key) throws -> Value
	where Key.RawValue == String {
		return try self.get_value(key: key.rawValue)
	}
}
