import CloudKit

public extension CKRecord {
	func get_value<Value>(key: String) -> Value? {
		return self[key] as? Value
	}
}
