public struct NamedGetOnlySubscript<Index, Value> {
	public typealias GetValue = (Index) -> Value
	
	public init(_ getValue: @escaping GetValue) {
		self.getValue = getValue
	}
	
	public subscript(index: Index) -> Value {
		return getValue(index)
	}
	
//MARK: private
	private let getValue: GetValue
}
