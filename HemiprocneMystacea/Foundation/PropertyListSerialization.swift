import Foundation

extension PropertyListSerialization {
	/// - Returns: 
	///   - propertyList: deserialized
	///   - format: in which it had been stored.
	static func deserialize(_ data: Data) throws -> (
		propertyList: Any,
		format: PropertyListFormat
	) {
		// This value doesn't matter;
		// it's just an inout needed for `format`
		// in the return tuple.
		var format: PropertyListFormat = .binary
		
		return (
			propertyList: try propertyList(
				from: data,
				format: &format
			),
			format: format
		)
	}
}
