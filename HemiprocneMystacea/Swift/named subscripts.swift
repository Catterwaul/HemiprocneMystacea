public struct NamedGetOnlySubscript<Index, Value> {
	typealias GetValue = (Index) -> Value
	
	init(_ getValue: @escaping GetValue) {
		self.getValue = getValue
	}
	
	subscript(index: Index) -> Value {
		return getValue(index)
	}
	
//MARK: private
	private let getValue: GetValue
}
