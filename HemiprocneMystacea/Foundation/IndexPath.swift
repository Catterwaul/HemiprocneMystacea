import Foundation

public extension IndexPath {
	///- Parameters:
	///- processables: usable like `processables[indexPath]`
	///- process: `process(_ processable: Processable)`
	
	///- Returns: `process(_ indexPath: IndexPath)`
	static func makeProcess<Processable>(
		processables: NamedGetOnlySubscript<IndexPath, Processable>,
		process: @escaping Process<Processable>
	) -> Process<IndexPath> {
		return {
			indexPath in process(processables[indexPath])
		}
	}
}
