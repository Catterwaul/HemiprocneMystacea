import Foundation

extension Data {
	/// - Returns: serialized property list
	init(
		propertyList: Any,
		format: PropertyListSerialization.PropertyListFormat
	) throws {
		try self = PropertyListSerialization.data(
			fromPropertyList: propertyList,
			format: format,
			options: .init()
		)
	}
}
