public extension EnumeratedSequence {
	/// - Throws: EnumeratedSequenceError
	func map<Transformed>(
		_ transform: (Base.Iterator.Element) throws -> Transformed
	) throws -> [Transformed] {
		return try self.map{
			(index, element) in do {
				return try transform(element)
			}
			catch {
				throw EnumeratedSequenceError(
					index: index,
					error: error
				)
			}
		}
	}
}

public struct EnumeratedSequenceError: Error {
	public let index: Int
	public let error: Error
}
