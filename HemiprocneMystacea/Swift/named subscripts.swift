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

public extension NamedGetOnlySubscript {
	/// This should take a sequence, not an array,
	/// but generic subscripts don't exist yet.
	subscript(indices: [Index]) -> [Value] {
		return indices.map{index in self[index]}
	}
	
	subscript(indices: Index...) -> [Value] {
		return self[indices]
	}
}
