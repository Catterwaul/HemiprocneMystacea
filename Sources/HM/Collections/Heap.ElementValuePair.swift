import HeapModule

public extension Heap {
  /// A "`Value`" that uses an accompanying `Heap.Element` for sorting  via a `Heap`.
  /// - Note: If `Value` itself is `Comparable`, it can of course be inserted into a Heap directly.
  ///   This type is explicitly for cases where a different sorting rule is desired.
  struct ElementValuePair<Value> {
    public var delegate: Element
    public var value: Value
  }
}

// MARK: - public
public extension Heap.ElementValuePair {
  init(_ delegate: Element, _ value: Value) {
    self.init(delegate: delegate, value: value)
  }
}

// MARK: - Comparable
extension Heap.ElementValuePair: ConformanceDelegator & Comparable { }

// MARK: - Sendable
extension Heap.ElementValuePair: Sendable where Element: Sendable, Value: Sendable { }
