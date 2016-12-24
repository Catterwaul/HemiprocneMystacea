import Foundation

public extension IndexPath {
	///- Parameters:
	///- getProcessable: the `get` for `processables[indexPath]`
	///- process: `process(_ processable: Processable)`
	
	///- Returns: `process(_ indexPath: IndexPath)`
	static func makeProcess<Processable>(
		getProcessable: @escaping (IndexPath) -> Processable,
		process: @escaping Process<Processable>
	) -> Process<IndexPath> {
		return {
			indexPath in process( getProcessable(indexPath) )
		}
	}
}
