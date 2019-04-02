import Foundation

public extension IndexPath {
	/// - Parameters:
	///   - processables: usable like: `processables[indexPath]`
	///   - process: `process(_ processable: Processable)`
	///
	///- Returns: `process(_ indexPath: IndexPath)`
	static func makeProcess<Processable>(
		processables: NamedGetOnlySubscript<IndexPath, Processable>,
		process: @escaping Process<Processable>
	) -> Process<IndexPath> {
		return { indexPath in process(processables[indexPath]) }
	}

  /// A shortcut for `IndexPath(item: item, section: 0)`
  init(_ item: Int) {
    self.init(item: item, section: 0)
  }
}

/// Should just be an extension on `() throws -> Element`
/// but you can't extend closures.
public func getElement<Element>(
  indexPath: IndexPath,
  getArray: Get<[Element]>
) throws -> Element {
  let array = try getArray()
  return try array.getElement(index: indexPath.item)
}
