// MARK: - AsyncThrowingSequence

import Combine

public protocol AsyncThrowingSequence: AsyncSequence { }

public extension AsyncThrowingSequence {
  var collected: [Element] {
    get async throws {
      try await reduce(into: []) { $0.append($1) }
    }
  }
}

extension AsyncThrowingCompactMapSequence: AsyncThrowingSequence { }
extension AsyncThrowingDropWhileSequence: AsyncThrowingSequence { }
extension AsyncThrowingFilterSequence: AsyncThrowingSequence { }
extension AsyncThrowingFlatMapSequence: AsyncThrowingSequence { }
extension AsyncThrowingMapSequence: AsyncThrowingSequence { }
extension AsyncThrowingPrefixWhileSequence: AsyncThrowingSequence { }
extension AsyncThrowingStream: AsyncThrowingSequence { }
extension ThrowingTaskGroup: AsyncThrowingSequence { }

// MARK: - AsyncNonThrowingSequence

public protocol AsyncNonThrowingSequence: AsyncSequence { }

public extension AsyncNonThrowingSequence {
  var collected: [Element] {
    get async {
      try! await reduce(into: []) { $0.append($1) }
    }
  }
}

extension AsyncCompactMapSequence: AsyncNonThrowingSequence { }
extension AsyncDropFirstSequence: AsyncNonThrowingSequence { }
extension AsyncDropWhileSequence: AsyncNonThrowingSequence { }
extension AsyncFilterSequence: AsyncNonThrowingSequence { }
extension AsyncFlatMapSequence: AsyncNonThrowingSequence { }
extension AsyncMapSequence: AsyncNonThrowingSequence { }
extension AsyncPrefixSequence: AsyncNonThrowingSequence { }
extension AsyncPrefixWhileSequence: AsyncNonThrowingSequence { }
extension AsyncStream: AsyncNonThrowingSequence { }
extension TaskGroup: AsyncNonThrowingSequence { }
