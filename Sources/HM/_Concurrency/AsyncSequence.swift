import AsyncAlgorithms
import HeapModule

public extension AsyncSequence {
  @inlinable func forEach(_ body: (Element) async throws -> Void) async rethrows {
    for try await element in self {
      try await body(element)
    }
  }
}

public extension Sequence where Element: Sendable {
  /// Transform a sequence asynchronously, and potentially in parallel.
  /// - Returns: An `AsyncSequence` which returns transformed elements, in their original order,
  /// as soon as they become available.
  func mapWithTaskGroup<Transformed: Sendable>(
    priority: TaskPriority? = nil,
    _ transform: @escaping @Sendable (Element) async -> Transformed
  ) -> AsyncChannel<Transformed> {
    let channel = AsyncChannel<Transformed>()
    Task { await mapWithTaskGroup(channel: channel, transform) }
    return channel
  }

  /// Transform a sequence asynchronously, and potentially in parallel.
  /// - Returns: An `AsyncSequence` which returns transformed elements, in their original order,
  /// as soon as they become available.
  func mapWithTaskGroup<Transformed: Sendable, Error: Swift.Error>(
    priority: TaskPriority? = nil,
    _ transform: @escaping @Sendable (Element) async throws(Error) -> Transformed
  ) -> AsyncThrowingChannel<Transformed, any Swift.Error> {
    let channel = AsyncThrowingChannel<Transformed, any Swift.Error>()
    Task {
      do {
        try await mapWithTaskGroup(channel: channel, transform)
      } catch {
        channel.fail(error)
      }
    }
    return channel
  }
  
  func compactMapWithTaskGroup<Transformed: Sendable>(
    priority: TaskPriority? = nil,
    _ transform: @escaping @Sendable (Element) async -> Transformed?
  ) async -> [Transformed] {
    await .init(mapWithTaskGroup(transform).compacted())
  }

  func compactMapWithTaskGroup<Transformed: Sendable, Error: Swift.Error>(
    priority: TaskPriority? = nil,
    _ transform: @escaping @Sendable (Element) async throws(Error) -> Transformed?
  ) async throws(any Swift.Error) -> [Transformed] {
    try await .init(mapWithTaskGroup(transform).compacted())
  }
}

// MARK: - private
private protocol AsyncChannelProtocol<Element> {
  associatedtype Element
  func send(_: Element) async
  func finish()
}

extension AsyncChannel: AsyncChannelProtocol { }
extension AsyncThrowingChannel: AsyncChannelProtocol { }

private extension Sequence where Element: Sendable {
  private func mapWithTaskGroup<Transformed: Sendable, Error: Swift.Error>(
    channel: some AsyncChannelProtocol<Transformed>,
    priority: TaskPriority? = nil,
    _ transform: @escaping @Sendable (Element) async throws(Error) -> Transformed
  ) async rethrows {
    typealias ChildTaskResult = Heap<Int>.ElementValuePair<Transformed>
    try await withThrowingTaskGroup(of: ChildTaskResult.self) { group in
      for (offset, element) in enumerated() {
        group.addTask(priority: priority) {
          .init(offset, try await transform(element))
        }
      }

      var heap = Heap<ChildTaskResult>()
      var lastSentOffset = -1
      for try await childTaskResult in group {
        heap.insert(childTaskResult)
        // Send as many in-order `Transformed`s as possible.
        while heap.min?.delegate == lastSentOffset + 1 {
          await channel.send(heap.removeMin().value)
          lastSentOffset += 1
        }
      }

      channel.finish()
    }
  }
}
