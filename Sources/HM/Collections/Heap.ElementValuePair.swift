import HeapModule

public extension Heap {
  /// A "`Value`" that uses an accompanying `Heap.Element` for sorting  via a `Heap`.
  /// - Note: If `Value` itself is `Comparable`, it can of course be inserted into a Heap directly.
  ///   This type is explicitly for cases where a different sorting rule is desired.
  typealias ElementValuePair<Value> = ConformerAndNonconformer<Element, Value>
}
