/// A rectangular matrix.
public struct Matrix<Element> {
  public var columns: [[Element]]
}

public extension Matrix {
  init(columns: some Sequence<some Sequence<Element>>) {
    self.columns = columns.map(Array.init)
  }

  init(rows: some Sequence<some Sequence<Element>>) {
    self.init(columns: rows.transposed)
  }

  var rows: [[Element]] {
    get { columns.transposed.map(Array.init) }
    set { columns = newValue.transposed.map(Array.init) }
  }
}
