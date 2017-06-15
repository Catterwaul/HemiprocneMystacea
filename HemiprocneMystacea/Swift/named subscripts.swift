public struct NamedGetOnlySubscript<Index, Value> {
  public typealias GetValue = (Index) -> Value
  
//MARK: private
  private let getValue: GetValue
}

public extension NamedGetOnlySubscript {
  init(_ getValue: @escaping GetValue) {
    self.getValue = getValue
  }
  
  subscript(index: Index) -> Value {
    return getValue(index)
  }
  
  subscript<Indices: Sequence>(indices: Indices) -> [Value]
  where Indices.Element == Index {
    return indices.map{self[$0]}
  }
  
  subscript(indices: Index...) -> [Value] {
    return self[indices]
  }
}
