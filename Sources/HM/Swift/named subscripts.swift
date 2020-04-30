/// An emulation of the missing Swift feature of named subscripts.
/// - Note: Argument labels are not supported.
public struct NamedGetOnlySubscript<Index, Value> {
  public typealias GetValue = (Index) -> Value
  
//MARK: private
  private let getValue: GetValue
}

public extension NamedGetOnlySubscript {
  /// - Parameter getValue: Provide a `Value` for an `Index`.
  init(_ getValue: @escaping GetValue) {
    self.getValue = getValue
  }
  
  subscript(index: Index) -> Value { getValue(index) }
  
  subscript<Indices: Sequence>(indices: Indices) -> [Value]
  where Indices.Element == Index {
    indices.map { self[$0] }
  }
  
  subscript(indices: Index...) -> [Value] { self[indices] }
}
